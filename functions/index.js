const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/**
 * Function to check birthdays daily and send notifications.
 */
exports.dailyBirthdayCheck = functions
    .pubsub.schedule("30 8 * * *") // Run at 8:30 AM daily
    .timeZone("Europe/London") // Set to Europe/London timezone
    .onRun(async (context) => {
      // Log at the beginning of the function
      console.log("Function started.");

      // Get today's date
      const today = new Date();
      console.log("Today:", today);

      // Query Firestore collections for individuals with birthdays today
      const coachBirthdays = await getBirthdays("Coaches", today);
      console.log("Coach Birthdays:", coachBirthdays);

      const managementBirthdays = await getBirthdays("ManagementBody", today);
      const firstTeamBirthdays =
      await getBirthdays("FirstTeamClassPlayers", today);
      const secondTeamBirthdays =
      await getBirthdays("SecondTeamClassPlayers", today);

      // Combine all birthdays
      const allBirthdays = [
        ...coachBirthdays,
        ...managementBirthdays,
        ...firstTeamBirthdays,
        ...secondTeamBirthdays,
      ];

      // Send notifications for each birthday
      await Promise.all(allBirthdays.map(sendNotification));

      // Log at the end of the function
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
  const snapshot = await admin.firestore().collection(collection)
      .where("d_o_b", "==", formatDate(today))
      .get();

  return snapshot.docs.map((doc) => doc.data()).filter(Boolean);
}

// Helper function to send a notification.

/**
 * Sends a birthday notification using FCM.
 * @param {Object} birthdayPerson - Data of the person having a birthday.
 * @param {string} birthdayPerson.fcmToken -
 * FCM token for sending notifications.
 * @param {string} birthdayPerson.name - Name of the person.
 */
async function sendNotification(birthdayPerson) {
  // Placeholder logic using FCM
  const registrationToken =
  birthdayPerson.fcmToken; // Replace with your field name
  const message = {
    data: {
      title: "Birthday Notification",
      body: `Happy Birthday, ${birthdayPerson.name}! 🎉`,
    },
    token: registrationToken,
  };

  try {
    await admin.messaging().send(message);
    console.log(`Notification sent to ${birthdayPerson.name}`);
  } catch (error) {
    console
        .error(`Error sending notification to ${birthdayPerson.name}:`, error);
  }
}

// Helper function to format the date to match Firestore date format

/**
 * Formats the date to match Firestore date format.
 * @param {string} date - The date to be formatted.
 * @return {string} Formatted date.
 */
function formatDate(date) {
  const options = {month: "long", day: "numeric"};
  return new Intl.DateTimeFormat("en-US", options)
      .format(new Date(date)).toUpperCase();
}