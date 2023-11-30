import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

String clubName = "Coventry Phoenix FC";
String title = "About Developer";
String clubAlmanac = "$clubName App, 2023";
String developerWebsite = "https://novelsoft.co.uk/";

String googlePlayServicesPolicyWebsite =
    "https://play.google.com/about/privacy-security-deception/";
String googleAnalyticsFirebasePolicyWebsite =
    "https://firebase.google.com/policies/analytics/";
String firebaseCrashlyticsPolicyWebsite =
    "https://firebase.google.com/support/privacy/";
String facebookPolicyWebsite = "https://web.facebook.com/about/privacy/";
String twitterPolicyWebsite = "https://twitter.com/en/privacy";
String instagramPolicyWebsite = "https://help.instagram.com/";
String linkedInPolicyWebsite = "https://www.linkedin.com/legal/privacy-policy";
String gmailPolicyWebsite = "https://firebase.google.com/support/privacy/";

String mailFIRST = "mailto:";
String mailSECOND = "?subject=Hello ";

String aboutApp =
    "PLEASE READ CAREFULLY.\n\nThis GFA (Grassroot Football App Software was engineered and developed by 'Nouvellesoft.io Inc.'";
String blemish =
    '"Do not be concerned about the blemishes and imperfections you may notice on the software, it is those blemishes that prove that the app is authentic. :)"';
String copyrightTerms =
    "This software is subject to copyright of Nouvellesoft.io Inc.. Hence should not be developed or replicated without due permission by any company or individual.";
String termsEtConditions =
    "The following are the terms and conditions attached to usage of this software;";
String termsEtConditions2 =
    "$clubName and/or her subsidiaries are the owners or the licensee of the materials published on this software, and are at freewill by this permission to share with her stakeholders, parents, staff and players.";
String termsEtConditions3 =
    "You may view and print material from our software for your personal non-commercial use. No other use is permitted without our prior written consent. In particular, you may not use any part of the materials on our software for commercial purposes without obtaining our prior written consent.";
String termsEtConditions4 =
    "You must not modify the paper or digital copies of any materials you have printed off or downloaded in any way, and you must not use any illustrations, photographs or any graphics separately from any accompanying text.";
String termsEtConditions5 =
    "The company's (or its subsidiaries') status (and that of any identified contributors) as the authors of materials on our software must always be acknowledged. No trademark, copyright or other proprietary notices contained in or appearing on material from our software should be altered or removed in whole or in part.";
String termsEtConditions6 =
    "The permission to reproduce material does not extend to material identified as belonging to third parties, where you must obtain the permission of the relevant owners before reproducing such material.";
String termsEtConditions7 =
    "If you print off, copy or download any part of our software in breach of these terms of use, your right to use our software will cease immediately and you must, at our option, return or destroy any copies of the materials you have made.";
String disclaimer = "Disclaimer/Liability";
String disclaimer1 =
    "Please note that this mobile software is linked to other websites that may have different terms of use and privacy policies. \nPlease refer to those websites for the appropriate information. \nPlease understand that Nouvellesoft.io Inc. has no control over the content of these third party websites. \nIn addition, a hyperlink to a non-Nouvelle Software Inc. website or link to access a third party mobile application does not mean that Nouvelle Software Inc. endorses or accepts any responsibility for the content, or the use, of the linked website or mobile application. \nIf you decide to access any of the third-party websites or mobile applications linked to this mobile software, you do so entirely at your own risk.";
String privacyPolicy = "Privacy Policy";
String privacyPolicy1 =
    "This text is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.";
String privacyPolicy2 =
    "If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. we will not use or share your information with anyone except as described in this Privacy Policy.";
String privacyPolicy3 =
    "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible in this software unless otherwise defined in this Privacy Policy.";
String infoCollection = "Information Collection and Use";
String infoCollection1 =
    "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information. The information that we request will be retained by us and used as described in this privacy policy.";
String infoCollection2 =
    "The app does use third party services that may collect information used to identify you.";
String infoCollection3 =
    "Link to privacy policy of third party service providers used by the app";
String infoCollectionLink1 = "Google Play Services";
String infoCollectionLink2 = "Google Analytics for Firebase";
String infoCollectionLink3 = "Firebase Crashlytics";
String infoCollectionLink4 = "Facebook";
String infoCollectionLink5 = "Twitter";
String infoCollectionLink6 = "Instagram";
String infoCollectionLink7 = "LinkedIn";
String infoCollectionLink8 = "Gmail";
String logData = "Log Data";
String logData1 =
    "We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. \nThis Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.";
String serviceProviders = "Service Providers";
String serviceProviders1 =
    "We may employ third-party companies and individuals due to the following reasons:";
String serviceProviders2 = "To facilitate our Service;";
String serviceProviders3 = "To provide the Service on our behalf;";
String serviceProviders4 = "To perform Service-related services; or";
String serviceProviders5 = "To assist us in analyzing how our Service is used.";
String serviceProviders6 =
    "We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.";
String security = "Security";
String security1 =
    "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. \nBut remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.";
String childrenPrivacy = "Children’s Privacy";
String childrenPrivacy1 =
    "These Services do not address anyone under the age of 16. We do not knowingly collect personally identifiable information from children under 16. \nIn the case we discover that a child under 16 has provided us with personal information, we immediately delete this from our servers. \nIf you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions. The services and information in this software and related contents strictly adheres and comply with The General Data Protection Regulation (GDPR) and The Information Commissioner's Office (ICO) regulations.";
String privacyPolicyChanges = "Changes to This Privacy Policy";
String privacyPolicyChanges1 =
    "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. This policy is effective as of 2021-04-30";
String contactUs = "Contact Us";
String contactUs1 =
    "If you have any questions or suggestions about our Terms and Conditions, Disclaimer, Privacy Policy, Software do not hesitate to send an email by clicking me too.";
String termsEtConditionsMore =
    "For more information about our terms and conditions, please click me.";

Color backgroundColor = const Color.fromRGBO(40, 38, 38, 1.0);
Color appBarTextColor = Colors.white.withAlpha(250);
Color appBarBackgroundColor = const Color.fromRGBO(40, 38, 38, 1.0);
Color appBarIconColor = Colors.white.withAlpha(250);
Color cardBackgroundColor =  const Color.fromRGBO(58, 55, 55, 1.0);
Color headingCardColor = Colors.white.withAlpha(250);
Color headingCardTextColor = const Color.fromRGBO(58, 55, 55, 1.0);
Color cardTextColor = Colors.white.withAlpha(250);

class AboutAppDetails extends StatefulWidget {
  const AboutAppDetails({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<AboutAppDetails> createState() => _AboutAppDetailsState();
}

// This class represents the stateful widget that displays the details about the app.
class _AboutAppDetailsState extends State<AboutAppDetails> {

  final _email = "david.oludepo@gmail.com";
  final _instagram = "nouvellesoft";
  final _twitter = "novelsoftinc";
  final _facebook = "novelsoft";
  final _linkedIn = "nouvellesoft";


  String mailFIRST = "mailto:";
  String mailSECOND = "?subject=Hello ";
  String urlTwitter = "https://twitter.com/";
  String urlFacebook = "https://facebook.com/";
  String urlLinkedIn = "https://linkedin.com/company/";
  String urlInstagram = "https://instagram.com/";


  @override
  Widget build(BuildContext context) {
    // Scaffold widget provides a framework for implementing the basic material design visual layout structure of the app.
    // It is the root of the widget tree for this screen.
    return Scaffold(
      // Background color of the scaffold.
      backgroundColor: backgroundColor,
      // AppBar widget provides a header section in the scaffold.
      appBar: AppBar(
        // Title of the app bar.
        title: Text(
          title,
          style: TextStyle(color: appBarTextColor),
        ),
        // Whether to center the title.
        centerTitle: true,
        // Elevation of the app bar shadow.
        elevation: 10,
        // Background color of the app bar.
        backgroundColor: appBarBackgroundColor,
        // Leading widget of the app bar.
        leading: IconButton(
          // Icon to be displayed.
          icon: Icon(Icons.arrow_back_ios, color: appBarIconColor),
          // Function to be called when the icon is pressed.
          onPressed: () {
            // Navigate to the previous screen when the back arrow is pressed.
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<int>(
            color: Colors.white,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Follow us on Instagram",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Follow us on Twitter",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text(
                  "Follow us on Facebook",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Text(
                  "Follow us on LinkedIn",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const PopupMenuItem<int>(
                value: 4,
                child: Text(
                  "Send us an Email",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
            onSelected: (item) {
              switch (item) {
                case 0:
                  launchSocialMedia(_instagram, urlInstagram);
                  break;
                case 1:
                  launchSocialMedia(_twitter, urlTwitter);
                  break;
                case 2:
                  launchSocialMedia(_facebook, urlFacebook);
                  break;
                case 3:
                  launchSocialMedia(_linkedIn, urlLinkedIn);
                  break;
                case 4:
                  launchURL(mailFIRST + _email + mailSECOND);
                  break;
              }
            },
          ),
        ],
      ),
      // Body widget of the scaffold.
      body: SingleChildScrollView(
        child: Column(
          // Alignment of the children widgets in the column.
          mainAxisAlignment: MainAxisAlignment.start,
          // List of children widgets of the column.
          children: <Widget>[
            // Card widget displays content within a Material Design card.
            Card(
              // Elevation of the card shadow.
              elevation: 10,
              // Margin of the card.
              margin: const EdgeInsets.all(20),
              // StreamBuilder widget listens to the Firestore collection and rebuilds itself whenever the collection changes.
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                // Stream that emits snapshots of the current contents of the Firestore document.
                stream: FirebaseFirestore.instance
                    .collection('SliversPages')
                    .doc('non_slivers_pages')
                    .snapshots(),
                // Function that gets called each time a new snapshot is available.
                builder: (context, snapshot) {
                  // Check if the snapshot has data.
                  if (!snapshot.hasData) {
                    // If the snapshot doesn't have data, return a circular progress indicator to indicate that the data is loading.
                    return const CircularProgressIndicator();
                  }
                  // If the snapshot has data, return a container with an image background.
                  return Container(
                    // Height of the container.
                    height: 300,
                    // Decoration of the container.
                    decoration: BoxDecoration(
                      // Image to be displayed as the background of the container.
                      image: DecorationImage(
                        // Cached network image provider that loads the image from the network and caches it.
                        image: CachedNetworkImageProvider(
                          snapshot.data?.data()!['about_app_page'],
                        ),
                        // Fit of the image within the container.
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            // This widget displays a Card with multiple TextSpan widgets that contain legal terms and information
            Card(
              // Sets the margin of the card
              margin: const EdgeInsets.all(20),
              // Sets the background color of the card
              color: cardBackgroundColor,
              child: Column(
                // Aligns children to the start of the main axis (vertical)
                mainAxisAlignment: MainAxisAlignment.start,
                // Aligns children to the end of the cross axis (horizontal)
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Adds a centered Card widget at the top of the column with the app title
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Card(
                        color: headingCardColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 30, right: 30),
                          child: Text(
                            // The app title
                            clubAlmanac,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: headingCardTextColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: -30.0,
                    runSpacing: 9.0,
                    children: [
                      SocialMediaButton(
                        icon: FontAwesomeIcons.facebook,
                        onPressed: () {
                          launchSocialMedia(_facebook, urlFacebook);
                        },
                      ),
                      SocialMediaButton(
                        icon: FontAwesomeIcons.instagram,
                        onPressed: () {
                          launchSocialMedia(_instagram, urlInstagram);
                        },
                      ),
                      SocialMediaButton(
                        icon: FontAwesomeIcons.linkedin,
                        onPressed: () {
                          launchSocialMedia(_linkedIn, urlLinkedIn);
                        },
                      ),
                      SocialMediaButton(
                        icon: FontAwesomeIcons.twitter,
                        onPressed: () {
                          launchSocialMedia(_twitter, urlTwitter);
                        },
                      ),
                      SocialMediaButton(
                        icon: Icons.email,
                        onPressed: () {
                          launchURL(mailFIRST + _email + mailSECOND);
                        },
                      ),
                      SocialMediaButton(
                        icon: FontAwesomeIcons.calendarCheck,
                        onPressed: () {
                          dynamic calendlyUrl = "https://calendly.com/david-oludepo";
                          launchURL(calendlyUrl);
                        },
                      ),
                      SocialMediaButton(
                        icon: FontAwesomeIcons.google,
                        onPressed: () {
                          dynamic websiteUrl = "https://novelsoft.co.uk";
                          launchURL(websiteUrl);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Adds a RichText widget with multiple TextSpan widgets that contain legal terms and information
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: RichText(
                      // Aligns the text to be justified
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children: <TextSpan>[
                          // Displays the app description text
                          TextSpan(
                            text: '$aboutApp\n\n\n',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // Displays a disclaimer text
                          TextSpan(
                            text: '$blemish\n\n\n',
                            style: TextStyle(
                                fontSize: 14,
                                color: cardTextColor,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic),
                          ),
                          // Displays the terms and conditions text
                          TextSpan(
                            text: '$termsEtConditions\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // Displays the copyright text
                          TextSpan(
                            text: '$copyrightTerms\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // Displays additional terms and conditions
                          TextSpan(
                            text: '$termsEtConditions2\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // Displays more terms and conditions
                          TextSpan(
                            text: '$termsEtConditions3\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$termsEtConditions4\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$termsEtConditions5\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$termsEtConditions6\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$termsEtConditions7\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$disclaimer\n\n',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '$disclaimer1\n\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$privacyPolicy\n\n',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '$privacyPolicy1\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$privacyPolicy2\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$privacyPolicy3\n\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$infoCollection\n\n',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '$infoCollection1\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$infoCollection2\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$infoCollection3\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                              text: '$infoCollectionLink1\n\n',
                              style: TextStyle(
                                fontSize: 15,
                                color: cardTextColor,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(googlePlayServicesPolicyWebsite as Uri);
                                }),
                          TextSpan(
                              text: '$infoCollectionLink2\n\n',
                              style: TextStyle(
                                fontSize: 15,
                                color: cardTextColor,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(googleAnalyticsFirebasePolicyWebsite as Uri);
                                }),
                          TextSpan(
                              text: '$infoCollectionLink3\n\n',
                              style: TextStyle(
                                fontSize: 15,
                                color: cardTextColor,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(firebaseCrashlyticsPolicyWebsite as Uri);
                                }),
                          TextSpan(
                              text: '$infoCollectionLink4\n\n',
                              style: TextStyle(
                                fontSize: 15,
                                color: cardTextColor,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(facebookPolicyWebsite as Uri);
                                }),
                          TextSpan(
                              text: '$infoCollectionLink5\n\n',
                              style: TextStyle(
                                fontSize: 15,
                                color: cardTextColor,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(twitterPolicyWebsite as Uri);
                                }),
                          TextSpan(
                              text: '$infoCollectionLink6\n\n',
                              style: TextStyle(
                                fontSize: 15,
                                color: cardTextColor,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(instagramPolicyWebsite as Uri);
                                }),
                          TextSpan(
                              text: '$infoCollectionLink7\n\n',
                              style: TextStyle(
                                fontSize: 15,
                                color: cardTextColor,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(linkedInPolicyWebsite as Uri);
                                }),
                          TextSpan(
                              text: '$infoCollectionLink8\n\n\n',
                              style: TextStyle(
                                fontSize: 15,
                                color: cardTextColor,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(gmailPolicyWebsite as Uri);
                                }),
                          TextSpan(
                            text: '$logData\n\n',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '$logData1\n\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$serviceProviders\n\n',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '$serviceProviders1\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$serviceProviders2\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$serviceProviders3\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$serviceProviders4\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$serviceProviders5\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$serviceProviders6\n\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$security\n\n',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '$security1\n\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$childrenPrivacy\n\n',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '$childrenPrivacy1\n\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$privacyPolicyChanges\n\n',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '$privacyPolicyChanges1\n\n\n',
                            style: TextStyle(
                              fontSize: 13,
                              color: cardTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '$contactUs\n\n',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: '$termsEtConditionsMore\n\n',
                              style: TextStyle(
                                fontSize: 14,
                                color: cardTextColor,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(developerWebsite as Uri);
                                }),
                          TextSpan(
                              text: '$contactUs1\n\n',
                              style: TextStyle(
                                fontSize: 14,
                                color: cardTextColor,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchURL(
                                      "${mailFIRST}hello@nouvellesoft.io$mailSECOND");
                                }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchSocialMedia(String handle, String url) async {
    final fullUrl = handle.startsWith('@') ? url + handle.substring(1) : url + handle;
    await launchURL(fullUrl);
  }

  Future launchURL(String url) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("The required app is not installed.")),
      );
    }
  }

}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  SocialMediaButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        elevation: 5.0,
        backgroundColor: const Color.fromRGBO(102, 97, 97, 1.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          icon,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }
}