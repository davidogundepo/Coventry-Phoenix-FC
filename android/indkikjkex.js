const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/**
 * Function to check birthdays daily and send general notifications.
 */
exports.dailyBirthdayCheck = functions
    .pubsub.schedule("25 5 * * *") // Run at 8:30 AM daily
    .timeZone("Europe/London") // Set to Europe/London timezone
    .onRun(async (context) => {
      console.log("Function started.");

      const today = new Date();
      console.log("Today:", today);

      // Log today's date in the desired format
      console.log("Formatted Today:", formatDate(today));

      // Query Firestore collections for individuals with birthdays today
      const coachBirthdays = await getBirthdays("Coaches", formatDate(today));
      console.log("Coach Birthdays:", coachBirthdays);

      const managementBirthdays =
        await getBirthdays("ManagementBody", formatDate(today));
      console.log("Management Birthdays:", managementBirthdays);

      const firstTeamBirthdays =
        await getBirthdays("FirstTeamClassPlayers", formatDate(today));
      console.log("First Team Birthdays:", firstTeamBirthdays);

      const secondTeamBirthdays =
        await getBirthdays("SecondTeamClassPlayers", formatDate(today));
      console.log("Second Team Birthdays:", secondTeamBirthdays);

      // Combine all birthdays
      const allBirthdays = [
        ...coachBirthdays,
        ...managementBirthdays,
        ...firstTeamBirthdays,
        ...secondTeamBirthdays,
      ];

      console.log("All Birthdays:", allBirthdays);

      // Send a general notification for all birthdays
      await sendGeneralNotification(allBirthdays);

      console.log("Function completed.");
      return null;
    });

/**
 * Gets birthdays for a specific collection and date.
 * @param {string} collection - The name of the Firestore collection.
 * @param {string} today - The date to check for birthdays.
 * @return {Array} An array of birthday data.
 */
async function getBirthdays(collection, today) {
  console.log(`Querying Firestore for ${collection} birthdays on ${today}`);

  const snapshot = await admin.firestore().collection(collection)
    .where("d_o_b", ">=", parseFirestoreDate(today))
    .where("d_o_b", "<", parseFirestoreDate(tomorrow(today)))
    .get();

  console.log(`Firestore query result for ${collection}:`);
  console.log(snapshot.docs.map((doc) => ({
    raw_d_o_b: doc.data().d_o_b,
    formatted_d_o_b: formatDate(parseFirestoreDate(doc.data().d_o_b)),
  })));

  // ... rest of the function
}

/**
 * Parses the Firestore date format into a JavaScript Date object.
 * @param {string} dateString - The date string.
 * @return {Date} The JavaScript Date object.
 */
function parseFirestoreDate(dateString) {
  // Extract day and month from the date string
  const matches = dateString.match(/^(\d+)(?:ST|ND|RD|TH)? (\w+)$/);

  if (!matches) {
    throw new Error(`Invalid date format: ${dateString}`);
  }

  const day = parseInt(matches[1]);
  const month = parseMonth(matches[2]);
  const currentYear = new Date().getFullYear(); // Assuming the current year

  return new Date(currentYear, month, day);
}

/**
 * Parses the month name into its corresponding index (0-based).
 * @param {string} monthName - The month name.
 * @return {number} The month index.
 */
function parseMonth(monthName) {
  const months = [
    "JANUARY", "FEBRUARY", "MARCH", "APRIL",
    "MAY", "JUNE", "JULY", "AUGUST",
    "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER",
  ];

  return months.indexOf(monthName.toUpperCase());
}

/**
 * Calculates the date for the next day.
 * @param {Date} today - The current date.
 * @return {Date} The date for the next day.
 */
function tomorrow(today) {
  const tomorrow = new Date(today);
  tomorrow.setDate(today.getDate() + 1);
  return tomorrow;
}

/**
 * Sends a general birthday notification without using individual FCM tokens.
 * @param {Array} allBirthdays - Array of birthday data.
 */
async function sendGeneralNotification(allBirthdays) {
  const message = {
    data: {
      title: "Birthday Notification",
      body: `Happy Birthday to everyone celebrating today! 🎉`,
    },
    // No token specified, sending a general notification
  };

  try {
    await admin.messaging().sendToTopic("birthdayTopic", message);
    console.log("General notification sent to all birthdays.");
  } catch (error) {
    console.error("Error sending general notification:", error);
  }
}

/**
 * Helper function to format the date to match Firestore date format.
 * @param {string} date - The date to be formatted.
 * @return {string} Formatted date.
 */
function formatDate(date) {
  const day = date.getDate();
  const options = { month: "long" };
  const month = new Intl.DateTimeFormat("en-US", options)
    .format(date).toUpperCase();
  return `${day}${getDaySuffix(day)} ${month}`;
}

/**
 * Gets the suffix for the day of the month (e.g., 1ST, 2ND, 3RD, etc.) in uppercase.
 * @param {number} day - The day of the month.
 * @return {string} The day suffix in uppercase.
 */
function getDaySuffix(day) {
  if (day >= 11 && day <= 13) {
    return "TH";
  }
  switch (day % 10) {
    case 1: return "ST";
    case 2: return "ND";
    case 3: return "RD";
    default: return "TH";
  }
}
