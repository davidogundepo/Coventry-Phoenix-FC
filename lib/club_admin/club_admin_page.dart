import 'package:coventry_phoenix_fc/api/club_sponsors_api.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:coventry_phoenix_fc/club_admin/add_club_member/a_tabview_add_club_member_page.dart';
import 'package:coventry_phoenix_fc/club_admin/modify_member/modify_coaches_page.dart';
import 'package:coventry_phoenix_fc/club_admin/modify_member/modify_management_page.dart';
import 'package:coventry_phoenix_fc/club_admin/sm_posts/create_new_sponsors_so_sm_post.dart';
import 'package:coventry_phoenix_fc/thrown_pages/club_sponsors_thrown_page.dart';
import 'package:coventry_phoenix_fc/club_admin/sm_posts/create_announcement_sm_post.dart';
import 'package:coventry_phoenix_fc/club_admin/sm_posts/create_matchday_sm_post.dart';
import 'package:coventry_phoenix_fc/club_admin/sm_posts/create_sponsors_so_sm_post.dart';
import 'package:coventry_phoenix_fc/club_admin/sm_posts/create_upcoming_event_sm_post.dart';
import 'package:coventry_phoenix_fc/notifier/club_sponsors_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/c_match_day_banner_for_club_api.dart';
import '../api/c_match_day_banner_for_club_opp_api.dart';
import '../api/c_match_day_banner_for_league_api.dart';
import '../api/c_match_day_banner_for_location_api.dart';
import '../api/club_captains_api.dart';
import '../api/coaching_staff_api.dart';
import '../api/first_team_class_api.dart';
import '../api/management_body_api.dart';
import '../api/second_team_class_api.dart';
import '../notifier/all_club_members_notifier.dart';
import '../notifier/all_fc_teams_notifier.dart';
import '../notifier/c_match_day_banner_for_club_notifier.dart';
import '../notifier/c_match_day_banner_for_club_opp_notifier.dart';
import '../notifier/c_match_day_banner_for_league_notifier.dart';
import '../notifier/c_match_day_banner_for_location_notifier.dart';
import '../notifier/players_notifier.dart';
import '../notifier/club_captains_notifier.dart';
import '../notifier/coaching_staff_notifier.dart';
import '../notifier/first_team_class_notifier.dart';
import '../notifier/management_body_notifier.dart';
import '../notifier/second_team_class_notifier.dart';
import '../sidebar/menu_item.dart';
import 'modify_club_sponsors/a_tabview_modify_club_sponsors_page.dart';
import 'modify_captains/a_tabview_modify_club_captains_page.dart';
import 'modify_member/modify_players_page.dart';
import 'modify_motm/a_tabview_modify_motm_page.dart';
import 'more_comm/modify_home_teams/a_tabview_modify_home_team_page.dart';
import 'more_comm/modify_leagues/a_tabview_modify_league_page.dart';
import 'more_comm/modify_locations/a_tabview_modify_location_page.dart';
import 'more_comm/modify_opp_teams/a_tabview_modify_opp_team_page.dart';
import 'modify_mvp/a_tabview_modify_mvp_page.dart';
import 'others/add_monthly_photos_page.dart';
import 'others/change_pages_cover_photo_page.dart';
import 'others/change_vision_statement_and_more_page.dart';
import 'others/modify_red_card/a_tabview_modify_red_card_page.dart';
import 'others/modify_yellow_card/a_tabview_modify_yellow_card_page.dart';
import 'others/record_club_achievement_page.dart';
import 'others/view_club_population_page.dart';

String chooseMVPOfTheMonthTitle = "Select MVP of the Month";
String chooseMOTMTitle = "Select Man of the Match";
String createSMPostTitle = "Create a Social Media Post";
String addMemberTitle = "Add Player(s), Coach(es) or Manager(s)";
String removeMemberTitle = "Remove Player(s), Coach(es) or Manager(s)";
String sponsorsTitle = "View Club Sponsors";
String commsTitle = "More Communications";
String selectedCaptainsTitle = "Select Club Captains";
String othersTitle = "Others";

Color backgroundColor = const Color.fromRGBO(34, 36, 54, 1.0);
Color gradientColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color gradientColorTwo = Colors.white;
Color gradientColorThree = const Color.fromRGBO(197, 33, 75, 1.0);
Color gradientColorFour = const Color.fromRGBO(70, 94, 213, 1.0);
Color linearGradientColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color linearGradientColorTwo = const Color.fromRGBO(24, 26, 36, 1.0);
Color boxShadowColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color dividerColor = Colors.white;
Color materialBackgroundColor = Colors.transparent;
Color shimmerBaseColor = Colors.white;
Color shimmerHighlightColor = Colors.white;
Color shapeDecorationTextColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color containerBackgroundColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color containerIconColor = Colors.white;
Color dialogBackgroundColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color dialogTextColor = Colors.white;
Color splashColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color splashColorTwo = Colors.white;
Color splashColorThree = Colors.black;
Color textColor = Colors.white;
Color textColorTwo = const Color.fromRGBO(24, 26, 36, 1.0);
Color textShadowColor = Colors.white;

Color blueColor = Colors.blueAccent;
Color redColor = Colors.red;
Color greenColor = Colors.green;
Color yellowColor = Colors.yellow;
Color brownColor = Colors.brown;
Color cyanColor = Colors.cyan;
Color whiteColor = Colors.white;
Color deepOrangeColor = Colors.deepOrange;
Color tealColor = Colors.teal;

class MyClubAdminPage extends StatefulWidget with NavigationStates {
  MyClubAdminPage({Key? key}) : super(key: key);

  @override
  State<MyClubAdminPage> createState() => MyClubAdminPageState();
}

class MyClubAdminPageState extends State<MyClubAdminPage> {


  Future launchURL(String url) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      scaffoldMessenger.showSnackBar(const SnackBar(content: Text("The required App not installed")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Club Admin',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        elevation: 10,
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            navigateMyApp(context);
          },
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: dividerColor.withOpacity(0.3),
                indent: 12,
                endIndent: 15,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: splashColorThree,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: containerBackgroundColor,
                          title: const Text(
                            'Select an Option',
                            style: TextStyle(color: Colors.white70, fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: const Text(
                                  'Publish MatchDay Fixtures',
                                  style: TextStyle(color: Colors.cyan, fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.pop(context); // Close the dialog
                                  navigateToCreateSMPost(context); // Navigate to the appropriate page
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  'Publish an Upcoming Event',
                                  style: TextStyle(color: Colors.cyan, fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  navigateToCreateUpcomingEventSMPost(context);
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  'Shout Out Current Sponsor',
                                  style: TextStyle(color: Colors.blueAccent, fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  navigateToCreateSponsorsShoutOutSMPost(context);
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  'Shout Out New Sponsor',
                                  style: TextStyle(color: Colors.blueAccent, fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  navigateToCreateNewSponsorsShoutOutSMPost(context);
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  'Publish an Announcement',
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                                onTap: () {
                                  // Navigator.pop(context);
                                  // navigateToCreateAnnouncementSMPost(context);

                                  Fluttertoast.showToast(
                                    msg: 'Coming Soon',
                                    // Show success message (you can replace it with actual banner generation logic)
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: blueColor.withAlpha(80),
                            ),
                            child: IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.handsAslInterpreting,
                                color: Colors.blue,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            createSMPostTitle,
                            style: TextStyle(color: gradientColorTwo, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: dividerColor.withOpacity(0.3),
                indent: 12,
                endIndent: 15,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: splashColorThree,
                  onTap: () {
                    {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: containerBackgroundColor,
                            title: const Text(
                              'Select an Option',
                              style: TextStyle(color: Colors.white70, fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: const Text(
                                    'See Club Sponsors',
                                    style: TextStyle(color: Colors.white70, fontSize: 14),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    navigateToClubSponsors(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text(
                                    'Modify Club Sponsors',
                                    style: TextStyle(color: Colors.white70, fontSize: 14),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    navigateToModifyClubSponsors(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: greenColor.withAlpha(80),
                            ),
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.jedi,
                                color: greenColor,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            sponsorsTitle,
                            style: TextStyle(color: gradientColorTwo, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: dividerColor.withOpacity(0.3),
                indent: 12,
                endIndent: 15,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: splashColorThree,
                  onTap: () {
                    navigateToModifyClubCaptains(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: brownColor.withAlpha(80),
                            ),
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.om,
                                color: redColor,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            selectedCaptainsTitle,
                            style: TextStyle(color: gradientColorTwo, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: dividerColor.withOpacity(0.3),
                indent: 12,
                endIndent: 15,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: splashColorThree,
                  onTap: () {
                    navigateToAddClubMember(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whiteColor.withAlpha(80),
                            ),
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.spider,
                                color: whiteColor,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            addMemberTitle,
                            style: TextStyle(color: gradientColorTwo, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: dividerColor.withOpacity(0.3),
                indent: 12,
                endIndent: 15,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: splashColorThree,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: containerBackgroundColor,
                          title: const Text(
                            'Select an Option',
                            style: TextStyle(color: Colors.white70, fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: const Text(
                                  'Remove Player(s)',
                                  style: TextStyle(color: Colors.cyan, fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.pop(context); // Close the dialog
                                  navigateToModifyAllClubPlayers(context); // Navigate to the appropriate page
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  'Remove Coaching Staff',
                                  style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  navigateToModifyCoaches(context);
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  'Removing Club Manager(s)',
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  navigateToModifyManagementBody(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: yellowColor.withAlpha(80),
                            ),
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.leaf,
                                color: yellowColor,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            removeMemberTitle,
                            style: TextStyle(color: gradientColorTwo, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: dividerColor.withOpacity(0.3),
                indent: 12,
                endIndent: 15,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: splashColorThree,
                  onTap: () {
                    navigateToModifyMVP(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: cyanColor.withAlpha(80),
                            ),
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.vrCardboard,
                                color: cyanColor,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            chooseMVPOfTheMonthTitle,
                            style: TextStyle(color: gradientColorTwo, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: dividerColor.withOpacity(0.3),
                indent: 12,
                endIndent: 15,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: splashColorThree,
                  onTap: () {
                    navigateToModifyPOTM(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: deepOrangeColor.withAlpha(80),
                            ),
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.dragon,
                                color: deepOrangeColor,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            chooseMOTMTitle,
                            style: TextStyle(color: gradientColorTwo, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: dividerColor.withOpacity(0.3),
                indent: 12,
                endIndent: 15,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: splashColorThree,
                  onTap: () {
                    {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: containerBackgroundColor,
                            title: const Text(
                              'Select an Option',
                              style: TextStyle(color: Colors.white70, fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: const Text(
                                    // 'Select Player of the Month',
                                    'Add new Home Team',
                                    style: TextStyle(color: Colors.white70, fontSize: 14),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context); // Close the dialog
                                    navigateToModifyHomeTeam(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text(
                                    // 'Add Monthly Reels',
                                    'Add new Opposition Team',
                                    style: TextStyle(color: Colors.white70, fontSize: 14),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context); // Close the dialog
                                    navigateToModifyOppTeam(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text(
                                    // 'Report an issue',
                                    'Add new League',
                                    style: TextStyle(color: Colors.white70, fontSize: 14),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context); // Close the dialog
                                    navigateToModifyLeague(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text(
                                    // 'Request a feature',
                                    'Add new Location',
                                    style: TextStyle(color: Colors.white70, fontSize: 14),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context); // Close the dialog
                                    navigateToModifyLocation(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tealColor.withAlpha(80),
                            ),
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.tree,
                                color: tealColor,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            commsTitle,
                            style: TextStyle(color: gradientColorTwo, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: dividerColor.withOpacity(0.3),
                indent: 12,
                endIndent: 15,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: splashColorThree,
                  onTap: () {
                    {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: containerBackgroundColor,
                            title: const Text(
                              'Select an Option',
                              style: TextStyle(color: Colors.white70, fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            content: SizedBox(
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text(
                                        "Generate Club Monthly Statement",
                                        style: TextStyle(color: Colors.cyan, fontSize: 13),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context); // Close the dialog
                                        // Show the confirmation dialog
                                        showConfirmationDialog(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text(
                                        "View Club's Population",
                                        style: TextStyle(color: Colors.greenAccent, fontSize: 13),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context); // Close the dialog
                                        navigateToViewClubPopulation(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Record Yellow Card(s)    🟨',
                                        style: TextStyle(color: Colors.orange, fontSize: 13),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context); // Close the dialog
                                        navigateToModifyYellowCard(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Record Red Card(s)    🟥',
                                        style: TextStyle(color: Colors.orange, fontSize: 13),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context); // Close the dialog
                                        navigateToModifyRedCard(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text(
                                        "Record Club Achievement(s)",
                                        style: TextStyle(color: Colors.green, fontSize: 13),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context); // Close the dialog
                                        navigateToRecordClubAchievement(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text(
                                        "Add Monthly Photos",
                                        style: TextStyle(color: Colors.redAccent, fontSize: 13),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context); // Close the dialog
                                        navigateToAddMonthlyPhotos(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text(
                                        "Change Page(s) Cover Photo(s) ",
                                        style: TextStyle(color: Colors.yellowAccent, fontSize: 13),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context); // Close the dialog
                                        navigateToChangePagesCoverPhoto(context);
                                      },
                                    ),
                                    // ListTile(
                                    //   title: const Text(
                                    //     "Change Vision Statement and More",
                                    //     style: TextStyle(color: Colors.pinkAccent, fontSize: 13),
                                    //   ),
                                    //   onTap: () {
                                    //     Navigator.pop(context); // Close the dialog
                                    //     navigateToChangeVisionStatementAndMore(context);
                                    //   },
                                    // ),
                                    ListTile(
                                      title: const Text(
                                        "Go To Video Tutorials",
                                        style: TextStyle(color: Colors.pinkAccent, fontSize: 13),
                                      ),
                                      onTap:  () {
                                        Navigator.pop(context); // Close the dialog
                                        dynamic videoUrl = 'https://www.youtube.com/@nouvellesoftinc/videos';
                                        launchURL(videoUrl);
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: brownColor.withAlpha(80),
                            ),
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.wandMagicSparkles,
                                color: brownColor,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            othersTitle,
                            style: TextStyle(color: gradientColorTwo, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 5,
                thickness: 0.5,
                color: dividerColor.withOpacity(0.3),
                indent: 12,
                endIndent: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();

    // Initialize Firebase first
    Firebase.initializeApp().whenComplete(() {
      if (kDebugMode) {
        print("Firebase initialized");
      }
    });

    // Fetch data for the first and second teams using their notifiers
    FirstTeamClassNotifier firstTeamNotifier = Provider.of<FirstTeamClassNotifier>(context, listen: false);
    getFirstTeamClass(firstTeamNotifier);

    SecondTeamClassNotifier secondTeamNotifier = Provider.of<SecondTeamClassNotifier>(context, listen: false);
    getSecondTeamClass(secondTeamNotifier);

    // Populate the PlayersNotifier with data from both teams
    PlayersNotifier playersNotifier = Provider.of<PlayersNotifier>(context, listen: false);

    playersNotifier.setFirstTeamPlayers(firstTeamNotifier.firstTeamClassList);
    playersNotifier.setSecondTeamPlayers(secondTeamNotifier.secondTeamClassList);

    CoachesNotifier coachesNotifier = Provider.of<CoachesNotifier>(context, listen: false);
    getCoaches(coachesNotifier);

    ManagementBodyNotifier managementBodyNotifier = Provider.of<ManagementBodyNotifier>(context, listen: false);
    getManagementBody(managementBodyNotifier);

    CaptainsNotifier clubCaptainsNotifier = Provider.of<CaptainsNotifier>(context, listen: false);
    getCaptains(clubCaptainsNotifier);

    ClubSponsorsNotifier clubSponsorsNotifier = Provider.of<ClubSponsorsNotifier>(context, listen: false);
    getClubSponsors(clubSponsorsNotifier);

    // Populate the AllClubMembersNotifier with data from both teams
    AllClubMembersNotifier allClubMembersNotifier = Provider.of<AllClubMembersNotifier>(context, listen: false);

    allClubMembersNotifier.setFirstTeamAllClubMembers(firstTeamNotifier.firstTeamClassList);
    allClubMembersNotifier.setSecondTeamAllClubMembers(secondTeamNotifier.secondTeamClassList);
    allClubMembersNotifier.setCoaches(coachesNotifier.coachesList);
    allClubMembersNotifier.setMGMTBody(managementBodyNotifier.managementBodyList);

    MatchDayBannerForClubNotifier matchDayBannerForClubNotifier = Provider.of<MatchDayBannerForClubNotifier>(context, listen: false);

    MatchDayBannerForClubOppNotifier matchDayBannerForClubOppNotifier = Provider.of<MatchDayBannerForClubOppNotifier>(context, listen: false);

    MatchDayBannerForLeagueNotifier matchDayBannerForLeagueNotifier = Provider.of<MatchDayBannerForLeagueNotifier>(context, listen: false);

    MatchDayBannerForLocationNotifier matchDayBannerForLocationNotifier = Provider.of<MatchDayBannerForLocationNotifier>(context, listen: false);

    getMatchDayBannerForClub(matchDayBannerForClubNotifier);
    getMatchDayBannerForClubOpp(matchDayBannerForClubOppNotifier);
    getMatchDayBannerForLeague(matchDayBannerForLeagueNotifier);
    getMatchDayBannerForLocation(matchDayBannerForLocationNotifier);

    AllFCTeamsNotifier allFCTeamsNotifier = Provider.of<AllFCTeamsNotifier>(context, listen: false);

    allFCTeamsNotifier.setMatchDayBannerForClubAllFCTeams(matchDayBannerForClubNotifier.matchDayBannerForClubList);
    allFCTeamsNotifier.setMatchDayBannerForClubOppAllFCTeams(matchDayBannerForClubOppNotifier.matchDayBannerForClubOppList);

    setState(() {});
  }
}

void showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundColor,
        title: const Text(
          'Generate Club Monthly Statement',
          style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'This will generate a statement about the club\'s activities so far this month. \n\nClick Yes to proceed.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700),
            ),
          ),
          TextButton(
            onPressed: () {
              // Implement the logic to proceed with generating the statement
              Navigator.of(context).pop(); // Close the dialog
              // Add your logic to generate the statement here
              // navigateToGenerateStatement(context);
              Fluttertoast.showToast(
                msg: 'Statement generated!',
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      );
    },
  );
}

Future navigateToCreateSMPost(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateMatchDaySocialMediaPost()));
}

Future navigateToCreateUpcomingEventSMPost(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUpcomingEventSMPost()));
}

Future navigateToCreateAnnouncementSMPost(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAnnouncementSMPost()));
}

Future navigateToCreateSponsorsShoutOutSMPost(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateSponsorsShoutOutSMPost()));
}

Future navigateToCreateNewSponsorsShoutOutSMPost(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewSponsorsShoutOutSMPost()));
}

Future navigateToClubSponsors(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyClubSponsorsPage(fromPage1: true)));
}

Future navigateToModifyClubSponsors(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewClubSponsorsPage()));
}

Future navigateToModifyClubCaptains(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewCaptainsPage()));
}

Future navigateToModifyCoaches(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyModifyCoachesPage()));
}

Future navigateToModifyManagementBody(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyModifyManagementBodyPage()));
}

Future navigateToModifyAllClubPlayers(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyModifyClubPlayersPage()));
}

Future navigateToAddClubMember(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewClubMemberPage()));
}

Future navigateToModifyHomeTeam(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewHomeTeamPage()));
}

Future navigateToModifyOppTeam(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewOppTeamPage()));
}

Future navigateToModifyLeague(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewLeaguePage()));
}

Future navigateToModifyLocation(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewLocationPage()));
}

Future navigateToModifyMVP(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewMVPPage()));
}

Future navigateToModifyPOTM(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewMOTMPage()));
}

Future navigateToModifyYellowCard(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewYellowCardPage()));
}

Future navigateToModifyRedCard(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TabviewRedCardPage()));
}

Future navigateToAddMonthlyPhotos(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyAddMonthlyPhotosPage()));
}

Future navigateToChangePagesCoverPhoto(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyChangePagesCoverPhotoPage()));
}

Future navigateToChangeVisionStatementAndMore(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyChangeVisionStatementAndMorePage()));
}

Future navigateToRecordClubAchievement(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyRecordClubAchievementPage()));
}

Future navigateToViewClubPopulation(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewClubPopulationPage()));
}


Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}
