import 'package:coventry_phoenix_fc/api/c_match_day_banner_for_club_api.dart';
import 'package:coventry_phoenix_fc/api/c_match_day_banner_for_club_opp_api.dart';
import 'package:coventry_phoenix_fc/api/c_match_day_banner_for_league_api.dart';
import 'package:coventry_phoenix_fc/api/c_match_day_banner_for_location_api.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:coventry_phoenix_fc/notifier/c_match_day_banner_for_club.dart';
import 'package:coventry_phoenix_fc/notifier/c_match_day_banner_for_club_opp.dart';
import 'package:coventry_phoenix_fc/notifier/c_match_day_banner_for_league.dart';
import 'package:coventry_phoenix_fc/notifier/c_match_day_banner_for_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


MatchDayBannerForClubNotifier? matchDayBannerForClubNotifier;
MatchDayBannerForClubOppNotifier? matchDayBannerForClubOppNotifier;
MatchDayBannerForLeagueNotifier? matchDayBannerForLeagueNotifier;
MatchDayBannerForLocationNotifier? matchDayBannerForLocationNotifier;

class CreateMatchdaySocialMediaPost extends StatefulWidget with NavigationStates{
   CreateMatchdaySocialMediaPost({Key? key}) : super(key: key);

  @override
  State<CreateMatchdaySocialMediaPost> createState() => CreateMatchdaySocialMediaPostState();
}

class CreateMatchdaySocialMediaPostState extends State<CreateMatchdaySocialMediaPost> {

  String? selectedTeamA = ''; // Store selected team A name
  String? selectedTeamB = ''; // Store selected team B name
  String? selectedLeague;
  String? selectedLocation;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;


  @override
  Widget build(BuildContext context) {
    matchDayBannerForClubNotifier = Provider.of<MatchDayBannerForClubNotifier>(context);

    matchDayBannerForClubOppNotifier =
    Provider.of<MatchDayBannerForClubOppNotifier>(context);

    matchDayBannerForLeagueNotifier =
    Provider.of<MatchDayBannerForLeagueNotifier>(context);

    matchDayBannerForLocationNotifier =
    Provider.of<MatchDayBannerForLocationNotifier>(context);

    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();



    return Scaffold(
      appBar: AppBar(
        title: Text('Matchday Fixtures'),
        titleTextStyle: TextStyle(
            color: Colors.blue,
            fontSize: 20
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _showTeamASelectionDialog(); // Show dialog for team A selection
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2), // Border for the square
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedTeamA!.isNotEmpty
                            ? Image.network(
                          matchDayBannerForClubNotifier!.matchDayBannerForClubList
                              .firstWhere((team) => team.clubName == selectedTeamA)
                              .clubIcon!,
                          width: 50,
                          height: 50,
                        )
                            : Icon(Icons.add), // Display team icon or '+' icon
                        SizedBox(height: 10),
                        Text(
                          selectedTeamA!,
                          style: GoogleFonts.tenorSans(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'VS',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showTeamBSelectionDialog(); // Show dialog for team B selection
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2), // Border for the square
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedTeamB!.isNotEmpty
                            ? Image.network(
                          matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList
                              .firstWhere((team) => team.clubName == selectedTeamB)
                              .clubIcon!,
                          width: 50,
                          height: 50,
                        )
                            : Icon(Icons.add), // Display team icon or '+' icon
                        SizedBox(height: 10),
                        Text(
                          selectedTeamB!,
                          style: GoogleFonts.tenorSans(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _showLeagueSelectionDialog(); // Show dialog for league selection
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2), // Border for the square
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          selectedLeague != null
                              ? Column(
                            children: [
                              Text(
                                selectedLeague!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          )
                              : Icon(Icons.add), // Display '+' icon or selected league
                          if (selectedLeague == null)
                            Text(
                              'Select League',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'AND',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showLocationSelectionDialog(); // Show dialog for location selection
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2), // Border for the square
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          selectedLocation != null
                              ? Column(
                                children: [
                                  Text(
                            selectedLocation!,
                            style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                            ),
                          ),
                                  SizedBox(height: 10),
                                ],
                              )
                              : Icon(Icons.add), // Display '+' icon or selected location
                          if (selectedLocation == null)
                          Text(
                            'Select Location',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        dateController.text = selectedDate.toString(); // Update the text field with the selected date
                        setState(() {
                          this.selectedDate = selectedDate;
                        });
                      }
                    },
                    child: Container(
                      // ... your container properties
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today),
                            SizedBox(height: 10),
                            Text(
                              'Select Date',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        timeController.text = selectedTime.format(context); // Update the text field with the selected time
                        setState(() {
                          this.selectedTime = selectedTime;
                        });
                      }
                    },
                    child: Container(
                      // ... your container properties
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time),
                            SizedBox(height: 10),
                            Text(
                              'Select Time',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (selectedDate != null && selectedTime != null) // Condition starts here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // 'Selected Date: ${DateFormat('d MMMM yyyy').format(selectedDate!)}',
                          'Selected Date:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 20), // Adjust spacing between date and time
                        Text(
                          'Selected Time: ${selectedTime!.format(context)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  // Condition ends here
                ],
              ),
            ),

            if (selectedDate != null && selectedTime != null) ...[



            ]


          ],
        ),
      ),
    );
  }


  void _showTeamASelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Team'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: matchDayBannerForClubNotifier!.matchDayBannerForClubList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                        selectedTeamA = matchDayBannerForClubNotifier!.matchDayBannerForClubList[index].clubName!;
                    });
                  },
                  title: Text(
                    matchDayBannerForClubNotifier!.matchDayBannerForClubList[index].clubName!,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  leading: Image.network(
                    matchDayBannerForClubNotifier!.matchDayBannerForClubList[index].clubIcon!,
                    width: 50,
                    height: 50,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showTeamBSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Team'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                        selectedTeamB = matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList[index].clubName!;
                    });
                  },
                  title: Text(
                    matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList[index].clubName!,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  leading: Image.network(
                    matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList[index].clubIcon!,
                    width: 50,
                    height: 50,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showLeagueSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a League'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: matchDayBannerForLeagueNotifier!.matchDayBannerForLeagueList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedLeague = matchDayBannerForLeagueNotifier!.matchDayBannerForLeagueList[index].league!;
                    });
                  },
                  title: Text(
                    matchDayBannerForLeagueNotifier!.matchDayBannerForLeagueList[index].league!,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showLocationSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Location'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: matchDayBannerForLocationNotifier!.matchDayBannerForLocationList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedLocation = matchDayBannerForLocationNotifier!.matchDayBannerForLocationList[index].location!;
                    });
                  },
                  title: Text(
                    matchDayBannerForLocationNotifier!.matchDayBannerForLocationList[index].location!,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }


  @override
  void initState() {
    MatchDayBannerForClubNotifier matchDayBannerForClubNotifier =
    Provider.of<MatchDayBannerForClubNotifier>(context, listen: false);

    MatchDayBannerForClubOppNotifier matchDayBannerForClubOppNotifier =
    Provider.of<MatchDayBannerForClubOppNotifier>(context, listen: false);

    MatchDayBannerForLeagueNotifier matchDayBannerForLeagueNotifier =
    Provider.of<MatchDayBannerForLeagueNotifier>(context, listen: false);

    MatchDayBannerForLocationNotifier matchDayBannerForLocationNotifier =
    Provider.of<MatchDayBannerForLocationNotifier>(context, listen: false);

    getMatchDayBannerForClub(matchDayBannerForClubNotifier);
    getMatchDayBannerForClubOpp(matchDayBannerForClubOppNotifier);
    getMatchDayBannerForLeague(matchDayBannerForLeagueNotifier);
    getMatchDayBannerForLocation(matchDayBannerForLocationNotifier);

    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
