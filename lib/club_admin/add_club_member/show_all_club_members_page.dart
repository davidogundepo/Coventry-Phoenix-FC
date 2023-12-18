import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import '../../api/coaching_staff_api.dart';
import '../../api/first_team_class_api.dart';
import '../../api/management_body_api.dart';
import '../../api/second_team_class_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/coaches.dart';
import '../../model/first_team_class.dart';
import '../../model/management_body.dart';
import '../../model/second_team_class.dart';
import '../../notifier/all_club_members_notifier.dart';
import '../../notifier/coaching_staff_notifier.dart';
import '../../notifier/first_team_class_notifier.dart';
import '../../notifier/management_body_notifier.dart';
import '../../notifier/second_team_class_notifier.dart';

Color conColor = const Color.fromRGBO(194, 194, 220, 1.0);
Color conColorTwo = const Color.fromRGBO(151, 147, 151, 1.0);
Color textColor = const Color.fromRGBO(222, 214, 214, 1.0);
Color whiteColor = const Color.fromRGBO(255, 253, 253, 1.0);
Color twitterColor = const Color.fromRGBO(36, 81, 149, 1.0);
Color instagramColor = const Color.fromRGBO(255, 255, 255, 1.0);
Color facebookColor = const Color.fromRGBO(43, 103, 195, 1.0);
Color snapchatColor = const Color.fromRGBO(222, 163, 36, 1.0);
Color youtubeColor = const Color.fromRGBO(220, 45, 45, 1.0);
Color websiteColor = const Color.fromRGBO(104, 79, 178, 1.0);
Color emailColor = const Color.fromRGBO(230, 45, 45, 1.0);
Color phoneColor = const Color.fromRGBO(20, 134, 46, 1.0);
Color backgroundColor = const Color.fromRGBO(237, 241, 241, 1.0);

// Define colors for different departments
Color playerColor = Colors.black; // Change the color based on your preference
Color coachColor = phoneColor; // Change the color based on your preference
Color managerColor = Colors.orange; // Change the color based on your preference

class MyShowAllClubMemberPage extends StatefulWidget with NavigationStates {
  MyShowAllClubMemberPage({Key? key}) : super(key: key);

  @override
  State<MyShowAllClubMemberPage> createState() =>
      MyShowAllClubMemberPageState();
}

class MyShowAllClubMemberPageState
    extends State<MyShowAllClubMemberPage> {
  bool isDeptSelected = false;
  bool isEditing = false; // Flag to determine if the user is in "Edit" mode
  List<String> selectedMemberNames = []; // List to store selected player names
  Map<String, String> memberDept = {}; // Map to store player-team mapping
  String selectedDept = ''; // Variable to store the selected team

  // Modify your build method like this
  @override
  Widget build(BuildContext context) {
    // Use the AllClubMembersNotifier to access the combined list of allClubMembers
    AllClubMembersNotifier allClubMembersNotifier =
    Provider.of<AllClubMembersNotifier>(context);

    // Create a copy of the allClubMembersList and sort it alphabetically by name
    List<dynamic> sortedMembers =
    List.from(allClubMembersNotifier.allClubMembersList);
    sortedMembers.sort((a, b) =>
        (a.name ?? 'No Name').toLowerCase().compareTo((b.name ?? 'No Name').toLowerCase()));

    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // Hide the keyboard when tapping outside the text field
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              // You can add logic here to show/hide the scrollbar based on scroll position
              return true;
            },
            child: Scrollbar(
              child: ListView.builder(
                itemCount: sortedMembers.length,
                itemBuilder: (context, index) {
                  final player = sortedMembers[index];
                  final memberName = player.name ?? 'No Name';
                  String deptForMember = '';

                  // Determine the department based on the type of player
                  if (player is FirstTeamClass || player is SecondTeamClass) {
                    deptForMember = 'Player';
                  } else if (player is Coaches) {
                    deptForMember = 'Coach';
                  } else if (player is ManagementBody) {
                    deptForMember = 'Manager';
                  }

                  // Assign color based on the department
                  Color memberColor = _getMemberColor(deptForMember);

                  final isCaptain = memberDept.containsKey(memberName);
                  final isSelected = selectedMemberNames.contains(memberName);

                  return ListTile(
                    title: Text(
                      '$memberName (${deptForMember.isNotEmpty ? deptForMember : 'No Department'})',
                      style: TextStyle(color: memberColor),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getMemberColor(String department) {
    // Return the color based on the department
    switch (department) {
      case 'Player':
        return playerColor;
      case 'Coach':
        return coachColor;
      case 'Manager':
        return managerColor;
      default:
        return Colors.blue; // Change the default color based on your preference
    }
  }

  @override
  void initState() {
    super.initState();

    // Fetch data for the first and second teams using their notifiers
    FirstTeamClassNotifier firstTeamNotifier =
    Provider.of<FirstTeamClassNotifier>(context, listen: false);
    getFirstTeamClass(firstTeamNotifier);

    SecondTeamClassNotifier secondTeamNotifier =
    Provider.of<SecondTeamClassNotifier>(context, listen: false);
    getSecondTeamClass(secondTeamNotifier);

    CoachesNotifier coachesNotifier =
    Provider.of<CoachesNotifier>(context, listen: false);
    getCoaches(coachesNotifier);

    ManagementBodyNotifier managementBodyNotifier =
    Provider.of<ManagementBodyNotifier>(context, listen: false);
    getManagementBody(managementBodyNotifier);

    // Populate the AllClubMembersNotifier with data from both teams
    AllClubMembersNotifier allClubMembersNotifier =
    Provider.of<AllClubMembersNotifier>(context, listen: false);

    allClubMembersNotifier.setFirstTeamAllClubMembers(firstTeamNotifier.firstTeamClassList);
    allClubMembersNotifier.setSecondTeamAllClubMembers(secondTeamNotifier.secondTeamClassList);
    allClubMembersNotifier.setCoaches(coachesNotifier.coachesList);
    allClubMembersNotifier.setMGMTBody(managementBodyNotifier.managementBodyList);
  }
}
