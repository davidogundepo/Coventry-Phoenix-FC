

import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:coventry_phoenix_fc/club_admin/add_club_member/a_tabview_add_club_member_page.dart';
import 'package:coventry_phoenix_fc/club_admin/modify_member/modify_coaches_page.dart';
import 'package:coventry_phoenix_fc/club_admin/modify_member/modify_management_page.dart';
import 'package:coventry_phoenix_fc/club_admin/club_sponsors/thrown_club_sponsors_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../api/club_captains_api.dart';
import '../api/coaching_staff_api.dart';
import '../api/first_team_class_api.dart';
import '../api/management_body_api.dart';
import '../api/second_team_class_api.dart';
import '../notifier/all_club_members_notifier.dart';
import '../notifier/players_notifier.dart';
import '../notifier/club_captains_notifier.dart';
import '../notifier/coaching_staff_notifier.dart';
import '../notifier/first_team_class_notifier.dart';
import '../notifier/management_body_notifier.dart';
import '../notifier/second_team_class_notifier.dart';
import '../sidebar/menu_item.dart';
import 'modify_captains/A_tabview_modify_club_captains_page.dart';
import 'modify_member/modify_players_page.dart';

String removeCoachTitle = "Remove Coaching Staff";
String removeManagerTitle = "Remove Club Manager(s)";
String addPlayerTitle = "Add Player(s), Coach(es) or Manager(s)";
String removePlayerTitle = "Remove Player(s)";
String sponsorsTitle = "See Club Sponsors";
String commsTitle = "More Communications";
String selectedCaptainsTitle = "Select Club Captains";
String othersTitle = "Others";


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
Color splashColorThree = Colors.white;
Color textColor = Colors.white;
Color textColorTwo = const Color.fromRGBO(24, 26, 36, 1.0);
Color textShadowColor = Colors.white;

class MyClubAdminPage extends StatefulWidget with NavigationStates{
  MyClubAdminPage({Key? key}) : super(key: key);

  @override
  State<MyClubAdminPage> createState() => MyClubAdminPageState();
}

class MyClubAdminPageState extends State<MyClubAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Admin',
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        elevation: 10,
        backgroundColor: containerBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            navigateMyApp(context);
          },
        ),
      ),
      backgroundColor: containerBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                    navigateToClubSponsors(context);
                    // Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MenuItems(
                        icon: MdiIcons.security,
                        title: sponsorsTitle,
                        textColor: gradientColorTwo
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
                    child: MenuItems(
                        icon: MdiIcons.security,
                        title: selectedCaptainsTitle,
                        textColor: gradientColorTwo
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
                    child: MenuItems(
                        icon: MdiIcons.security,
                        title: addPlayerTitle,
                        textColor: gradientColorTwo
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
                    navigateToModifyAllClubPlayers(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MenuItems(
                        icon: MdiIcons.security,
                        title: removePlayerTitle,
                        textColor: gradientColorTwo
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
                    navigateToModifyCoaches(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MenuItems(
                        icon: MdiIcons.security,
                        title: removeCoachTitle,
                        textColor: gradientColorTwo
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
                    navigateToModifyManagementBody(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MenuItems(
                        icon: MdiIcons.security,
                        title: removeManagerTitle,
                        textColor: gradientColorTwo
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
                    BlocProvider.of<NavigationBloc>(context).add(
                        NavigationEvents
                            .myClubSponsorsPageClickedEvent);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MenuItems(
                        icon: MdiIcons.security,
                        title: commsTitle,
                        textColor: gradientColorTwo
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
                    BlocProvider.of<NavigationBloc>(context).add(
                        NavigationEvents
                            .myClubSponsorsPageClickedEvent);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MenuItems(
                        icon: MdiIcons.security,
                        title: othersTitle,
                        textColor: gradientColorTwo
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

      // Fetch data for the first and second teams using their notifiers
      FirstTeamClassNotifier firstTeamNotifier =
      Provider.of<FirstTeamClassNotifier>(context, listen: false);
      getFirstTeamClass(firstTeamNotifier);

      SecondTeamClassNotifier secondTeamNotifier =
      Provider.of<SecondTeamClassNotifier>(context, listen: false);
      getSecondTeamClass(secondTeamNotifier);

      // Populate the PlayersNotifier with data from both teams
      PlayersNotifier playersNotifier =
      Provider.of<PlayersNotifier>(context, listen: false);

      playersNotifier.setFirstTeamPlayers(firstTeamNotifier.firstTeamClassList);
      playersNotifier.setSecondTeamPlayers(secondTeamNotifier.secondTeamClassList);

      CoachesNotifier coachesNotifier =
      Provider.of<CoachesNotifier>(context, listen: false);
      getCoaches(coachesNotifier);

      ManagementBodyNotifier managementBodyNotifier =
      Provider.of<ManagementBodyNotifier>(context, listen: false);
      getManagementBody(managementBodyNotifier);

      CaptainsNotifier clubCaptainsNotifier =
      Provider.of<CaptainsNotifier>(context, listen: false);
      getCaptains(clubCaptainsNotifier);

      // Populate the AllClubMembersNotifier with data from both teams
      AllClubMembersNotifier allClubMembersNotifier =
      Provider.of<AllClubMembersNotifier>(context, listen: false);

      allClubMembersNotifier.setFirstTeamAllClubMembers(firstTeamNotifier.firstTeamClassList);
      allClubMembersNotifier.setSecondTeamAllClubMembers(secondTeamNotifier.secondTeamClassList);
      allClubMembersNotifier.setCoaches(coachesNotifier.coachesList);
      allClubMembersNotifier.setMGMTBody(managementBodyNotifier.managementBodyList);

      setState(() {});
    });
  }
}

Future navigateToClubSponsors(context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => MyClubSponsorsPage()));
}
Future navigateToModifyClubCaptains(context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => TabviewCaptainsPage()));
}
Future navigateToModifyCoaches(context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => MyModifyCoachesPage()));
}
Future navigateToModifyManagementBody(context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => MyModifyManagementBodyPage()));
}
Future navigateToModifyAllClubPlayers(context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => MyModifyClubPlayersPage()));
}
Future navigateToAddClubMember(context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => TabviewClubMemberPage()));
}



Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}
