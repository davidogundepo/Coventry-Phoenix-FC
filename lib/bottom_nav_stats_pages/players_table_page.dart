import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:coventry_phoenix_fc/details_pages/second_team_details_page.dart';
import 'package:coventry_phoenix_fc/notifier/second_team_class_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:toast/toast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import '../details_pages/first_team_details_page.dart';
import '../notifier/first_team_class_notifier.dart';

Color conColor = const Color.fromRGBO(34, 40, 49, 1);
Color? backgroundColor = const Color.fromRGBO(34, 40, 49, 1);
Color? cardBackgroundColorTwo =
    const Color.fromRGBO(34, 40, 49, 0.6);
Color? cardBackgroundColor = const Color.fromRGBO(57, 62, 70, 1);
Color? goalsScoredTextColor = const Color.fromRGBO(255, 141, 41, 1);
Color? appBarIconColor = const Color.fromRGBO(255, 141, 41, 1);
Color? appBarBackgroundColor = const Color.fromRGBO(34, 40, 49, 1);

String lottieTrainingSoccerTitle = "assets/json/training_soccer.json";
String lottieTrialSoccerTitle = "assets/json/trial_soccer.json";

// final List<PlayersTable> playersTableList = [];

FirstTeamClassNotifier? firstTeamClassNotifier;
SecondTeamClassNotifier? secondTeamClassNotifier;

class PlayersTablePage extends StatefulWidget {
  const PlayersTablePage({Key? key}) : super(key: key);

  @override
  State<PlayersTablePage> createState() => PlayersTablePageState();
}

class PlayersTablePageState extends State<PlayersTablePage> {
  List<PlayersTable> playersTableList = [];

  late PlayersTableDataSource playersTableDataSource;

  Stream<QuerySnapshot> getDataFromFirestore() {
    return FirebaseFirestore.instance
        .collection('PllayersTable')
        .orderBy('goals_scored', descending: true)
        .snapshots();
  }

  _buildDataGrid() {
    firstTeamClassNotifier =
        Provider.of<FirstTeamClassNotifier>(context, listen: false);
    secondTeamClassNotifier =
        Provider.of<SecondTeamClassNotifier>(context, listen: false);
    return StreamBuilder(
        stream: getDataFromFirestore(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (playersTableList.isNotEmpty &&
                !snapshot.data!.metadata.isFromCache) {
              realTimeUpdate(var data) {
                return DataGridRow(cells: [
                  DataGridCell<String>(columnName: 'id', value: data.doc['id']),
                  DataGridCell<String>(
                      columnName: 'image', value: data.doc['image']),
                  DataGridCell<String>(
                      columnName: 'player_name',
                      value: data.doc['player_name']),
                  DataGridCell<int>(
                      columnName: 'matches_played',
                      value: data.doc['matches_played']),
                  DataGridCell<int>(
                      columnName: 'matches_started',
                      value: data.doc['matches_started']),
                  DataGridCell<int>(
                      columnName: 'matches_benched',
                      value: data.doc['matches_benched']),
                  DataGridCell<int>(
                      columnName: 'goals_scored',
                      value: data.doc['goals_scored']),
                  DataGridCell<int>(
                      columnName: 'assists', value: data.doc['assists']),
                  DataGridCell<int>(
                      columnName: 'yellow_card',
                      value: data.doc['yellow_card']),
                  DataGridCell<int>(
                      columnName: 'red_card', value: data.doc['red_card']),
                  DataGridCell<String>(
                      columnName: 'player_position',
                      value: data.doc['player_position']),
                  DataGridCell<String>(
                      columnName: 'nationality',
                      value: data.doc['nationality']),
                ]);
              }

              for (var data in snapshot.data!.docChanges) {
                if (data.type == DocumentChangeType.modified) {
                  playersTableDataSource.dataGridRows[data.oldIndex] =
                      realTimeUpdate(data);
                  playersTableDataSource.updateDataGridSource();
                } else if (data.type == DocumentChangeType.added) {
                  playersTableDataSource.dataGridRows.add(realTimeUpdate(data));
                  playersTableDataSource.updateDataGridSource();
                } else if (data.type == DocumentChangeType.removed) {
                  playersTableDataSource.dataGridRows.removeAt(data.oldIndex);
                  playersTableDataSource.updateDataGridSource();
                }
              }
            } else if (playersTableList.isEmpty) {
              for (var data in snapshot.data!.docs) {
                playersTableList.add(PlayersTable(
                    id: data['id'],
                    image: data['image'],
                    playerName: data['player_name'],
                    matchesPlayed: data['matches_played'],
                    matchesStarted: data['matches_started'],
                    matchesBenched: data['matches_benched'],
                    goalsScored: data['goals_scored'],
                    assists: data['assists'],
                    playerPosition: data['player_position'],
                    yellowCard: data['yellow_card'],
                    redCard: data['red_card'],
                    nationality: data['nationality']));
              }
              playersTableDataSource = PlayersTableDataSource(playersTableList);
            }

            return SizedBox(
              height: 700,
              child: Material(
                color: cardBackgroundColorTwo,
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                      // sortIcon: const Icon(Icons.arrow_circle_up),
                      sortIconColor: Colors.white,
                      headerColor: cardBackgroundColorTwo,
                      gridLineColor: backgroundColor,
                      gridLineStrokeWidth: 1.0),
                  child: SfDataGrid(
                    rowHeight: 50,
                    source: playersTableDataSource,
                    onCellTap: (details) {
                      if (details.column.columnName == 'player_name' &&
                          details.rowColumnIndex.rowIndex > 0) {
                        DataGridRow row = playersTableDataSource.effectiveRows
                            .elementAt(details.rowColumnIndex.rowIndex - 1);

                        String playerName = row
                            .getCells()
                            .firstWhere((element) =>
                                element.columnName == 'player_name')
                            .value
                            .toString();

                        var firstTeamPlayer = firstTeamClassNotifier
                            ?.firstTeamClassList
                            .firstWhereOrNull(
                                (element) => element.name == playerName);

                        var secondTeamPlayer = secondTeamClassNotifier
                            ?.secondTeamClassList
                            .firstWhereOrNull(
                                (element) => element.name == playerName);

                        if (firstTeamPlayer != null) {
                          firstTeamClassNotifier?.currentFirstTeamClass =
                              firstTeamPlayer;
                          navigateToSubPage(context);

                          Toast.show("Loading up $playerName",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom,
                              backgroundRadius: 10);
                        } else if (secondTeamPlayer != null) {
                          secondTeamClassNotifier?.currentSecondTeamClass =
                              secondTeamPlayer;
                          navigateToSecondTeamClassDetailsPage(context);

                          Toast.show("Loading up $playerName",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom,
                              backgroundRadius: 10);
                        } else {
                          Toast.show("Ummmm, we can't find $playerName",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom,
                              backgroundRadius: 10);
                        }
                      }
                    },
                    frozenColumnsCount: 3,
                    frozenRowsCount: 0,
                    allowSorting: true,
                    allowTriStateSorting: true,
                    // allowMultiColumnSorting: true,
                    columnWidthMode: ColumnWidthMode.fill,
                    tableSummaryRows: [
                      GridTableSummaryRow(
                          color: cardBackgroundColorTwo,
                          showSummaryInRow: true,
                          title:
                              '{Goals} Goals and {Ass} Assists by {Count} players so far.',
                          columns: [
                            const GridSummaryColumn(
                                name: 'Goals',
                                columnName: 'goals_scored',
                                summaryType: GridSummaryType.sum),
                            const GridSummaryColumn(
                                name: 'Ass',
                                columnName: 'assists',
                                summaryType: GridSummaryType.sum),
                            const GridSummaryColumn(
                                name: 'Count',
                                columnName: 'id',
                                summaryType: GridSummaryType.count),
                          ],
                          position: GridTableSummaryRowPosition.bottom)
                    ],
                    columns: getColumns,
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  List<GridColumn> get getColumns {
    return <GridColumn>[
      GridColumn(
          columnName: 'id',
          width: 45,
          allowSorting: true,
          label: Container(
              alignment: Alignment.center,
              // padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'ID',
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'image',
          width: 70,
          allowSorting: false,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Image',
                  style: TextStyle(color: Colors.white70),
                  overflow: TextOverflow.ellipsis))),
      GridColumn(
          columnName: 'player_name',
          width: 120,
          label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: const Text(
                'Player Name',
                softWrap: true,
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'matches_played',
          width: 50,
          label: Container(
              alignment: Alignment.centerLeft,
              child: const Text(' MP', //'Matches Played',
                  style: TextStyle(color: Colors.white70),
                  overflow: TextOverflow.ellipsis))),
      GridColumn(
          columnName: 'goals_scored',
          allowSorting: true,
          width: 50,
          label: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                ' GS', //'Goals Scored'
                style: TextStyle(
                    color: goalsScoredTextColor,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ))),
      // GridColumn(
      //     columnName: 'assists',
      //     width: 50,
      //     label: Container(
      //         alignment: Alignment.centerLeft,
      //         child: const Text(
      //           ' A', //'Assists'
      //           style: TextStyle(color: Colors.white70),
      //           overflow: TextOverflow.ellipsis,
      //         ))),
      GridColumn(
          columnName: 'matches_started',
          width: 50,
          label: Container(
              alignment: Alignment.centerLeft,
              child: const Text(' MS', //'Matches Played',
                  style: TextStyle(color: Colors.white70),
                  overflow: TextOverflow.ellipsis))),
      GridColumn(
          columnName: 'matches_benched',
          width: 50,
          label: Container(
              alignment: Alignment.centerLeft,
              child: const Text(' MB', //'Matches Played',
                  style: TextStyle(color: Colors.white70),
                  overflow: TextOverflow.ellipsis))),
      GridColumn(
          columnName: 'yellow_card',
          width: 50,
          label: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'YC', //'Yellow\nCard'
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'red_card',
          width: 50,
          label: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'RC', //'Red\nCard'
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'player_position',
          width: 60,
          label: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                '  PP', //'Player Position'
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'nationality',
          width: 120,
          label: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Nationality',
                style: TextStyle(
                  color: Colors.white70,
                ),
                overflow: TextOverflow.ellipsis,
              ))),
    ];
  }

  @override
  void initState() {
    // getDataFromFirestore();
    // if (playersTableList.isEmpty) {
    playersTableDataSource = PlayersTableDataSource(playersTableList);
    playersTableDataSource.sortedColumns.add(const SortColumnDetails(
        name: 'goals_scored', sortDirection: DataGridSortDirection.descending));
    // }

    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final useMaterial3 = Theme.of(context).useMaterial3;
    final borderRadius = useMaterial3
        ? const BorderRadius.all(Radius.circular(16))
        : const BorderRadius.all(Radius.circular(4));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('SliversPages')
                  .doc('non_slivers_pages')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data?.data()!['players_table'],
                      style: TextStyle(color: appBarIconColor, fontSize: 17));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: appBarIconColor),
            onPressed: () {
              // Navigator.of(context).pop(false);
              navigateMyApp(context);
            },
          ),
          actions: [
            PopupMenuButton(
                color: const Color.fromRGBO(57, 62, 70, 1),
                icon: const Icon(
                  Icons.menu,
                  color: Color.fromRGBO(255, 141, 41, 1),
                ),
                itemBuilder: (context) => [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text(
                          "Legend",
                          style:
                              TextStyle(color: Color.fromRGBO(255, 141, 41, 1)),
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text(
                          "Training Days",
                          style:
                              TextStyle(color: Color.fromRGBO(255, 141, 41, 1)),
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 2,
                        child: Text(
                          "Trial Periods",
                          style:
                              TextStyle(color: Color.fromRGBO(255, 141, 41, 1)),
                        ),
                      ),
                    ],
                onSelected: (item) {
                  switch (item) {
                    case 0:
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: const Color.fromRGBO(57, 62, 70, 1),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Acronyms',
                                  style: TextStyle(
                                      color: Colors.white70,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.70,
                                child: const SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'A.P.T. - All Players Table',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'ID - Identification',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'MP - Matches Played',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'MS - Matches Started',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'MB - Matches Benched',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'GS - Goals Scored',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'A - Assists',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'YC - Yellow Cards',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'RC - Red Cards',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'PP - Players Positions',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'FC - Football Club',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'MOTM - Man Of The Match',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'POTM - Player Of The Match',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'CB - Center Back',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'LB - Left Back',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'RB - Right Back',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'GK - Goal Keeper',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'CM - Central Midfielder',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'CDM - Central Defensive Midfielder',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'LM - Left Midfielder',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'RM - Right Midfielder',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'AM - Attacking Midfielder',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'LW - Left Winger',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'RW - Right Winger',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'CF - Center Forward',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Goals Con. - Goals Conceded',
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Okay'),
                                child: const Text(
                                  'Okay',
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 141, 41, 1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      break;
                    case 1:
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: const Color.fromRGBO(57, 62, 70, 1),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Lottie.asset(
                                  lottieTrainingSoccerTitle,
                                  height: 200,
                                  width: 250,
                                ),
                              ),
                              const Text(
                                'Training Days',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                    width: width/1.19,
                                    height: width/1.6,
                                    decoration: BoxDecoration(
                                      color: conColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text.rich(
                                      textAlign:TextAlign.justify,
                                      TextSpan(
                                        children: <TextSpan>[
                                          // TextSpan(
                                          //     text:  'Tuesdays\n',
                                          //     style: GoogleFonts.aldrich(
                                          //       color: Colors.white70,
                                          //       fontSize: 22,
                                          //       fontWeight: FontWeight.w700,
                                          //     )),
                                          // TextSpan(
                                          //     text:
                                          //     '  🔹At Moat House Leisure, Winston Ave, Coventry CV2 1EA [7pm - 8pm].\n\n\n\n\n',
                                          //     style: GoogleFonts.aldrich(
                                          //       color: Colors.white70,
                                          //       fontSize: 14,
                                          //       fontWeight: FontWeight.w300,
                                          //     )),
                                          TextSpan(
                                              text:  'Thursdays\n',
                                              style: GoogleFonts.aldrich(
                                                color: Colors.white70,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          TextSpan(
                                              text:
                                              '  🔹At The Alan Higgs Centre, Allard Way, Coventry CV3 1HW [8pm - 10pm].',
                                              style: GoogleFonts.aldrich(
                                                color: Colors.white70,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Okay'),
                                child: const Text(
                                  'Okay',
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 141, 41, 1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      break;
                    case 2:
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: const Color.fromRGBO(57, 62, 70, 1),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Lottie.asset(
                                  lottieTrialSoccerTitle,
                                  height: 200,
                                  width: 250,
                                ),
                              ),
                              const Text(
                                'Trial  Periods',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  width: width/1.19,
                                  height: width/1.6,
                                  decoration: BoxDecoration(
                                    color: conColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text.rich(
                                      textAlign:TextAlign.justify,
                                      TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:  'Monthly\n',
                                              style: GoogleFonts.aldrich(
                                                color: Colors.white70,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          TextSpan(
                                              text:
                                              '  🔹Every month we hold trials on Thursdays between 8pm-10pm.\n\n',
                                              style: GoogleFonts.aldrich(
                                                color: Colors.white70,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                              )),
                                          TextSpan(
                                              text:  'Location\n',
                                              style: GoogleFonts.aldrich(
                                                color: Colors.white70,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          TextSpan(
                                              text:
                                              ' 🔹At The Alan Higgs Centre, Allard Way, Coventry CV3 1HW.\n\n',
                                              style: GoogleFonts.aldrich(
                                                color: Colors.white70,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                              )),
                                          TextSpan(
                                              text:  'Please Note\n',
                                              style: GoogleFonts.aldrich(
                                                color: Colors.white70,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          TextSpan(
                                              text:
                                              '  🔹Come on time, prepare to be tested and we wish you good luck.\n\n',
                                              style: GoogleFonts.aldrich(
                                                color: Colors.white70,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                              )),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Okay'),
                                child: const Text(
                                  'Okay',
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 141, 41, 1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      break;
                    default:
                      break;
                  }
                }),
          ],
          elevation: 10,
          backgroundColor: appBarBackgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 10,
              color: cardBackgroundColor,
              child: _buildDataGrid()),
        ),
      ),
    );
  }

  Future navigateMyApp(context) async {
    Navigator.of(context).pop(false);
  }

  Future<bool> _onWillPop() {
    Navigator.of(context).pop(false);
    return Future.value(true);
  }
}

class PlayersTableDataSource extends DataGridSource {
  PlayersTableDataSource(this.playersTableList) {
    sort();
    _buildDataRow();
  }

  List<PlayersTable> playersTableList = [];

  List<DataGridRow> dataGridRows = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => dataGridRows.isEmpty ? [] : dataGridRows;

  /// Creates the playersTable data source class with required page..

  void _buildDataRow() {
    int itemCount = 1;

    dataGridRows = playersTableList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: itemCount++),
              DataGridCell<String>(columnName: 'image', value: e.image),
              DataGridCell<String>(
                  columnName: 'player_name', value: e.playerName),
              DataGridCell<int>(
                  columnName: 'matches_played', value: e.matchesPlayed),
              DataGridCell<int>(
                  columnName: 'goals_scored', value: e.goalsScored),
              // DataGridCell<int>(columnName: 'assists', value: e.assists),
              DataGridCell<int>(
                  columnName: 'matches_started', value: e.matchesStarted),
              DataGridCell<int>(
                  columnName: 'matches_benched', value: e.matchesBenched),
              DataGridCell<int>(columnName: 'yellow_card', value: e.yellowCard),
              DataGridCell<int>(columnName: 'red_card', value: e.redCard),
              DataGridCell<String>(
                  columnName: 'player_position', value: e.playerPosition),
              DataGridCell<String>(
                  columnName: 'nationality', value: e.nationality),
            ]))
        .toList();
  }

  @override
  Widget buildTableSummaryCellWidget(
      GridTableSummaryRow? summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex? rowColumnIndex,
      String? summaryValue) {
    // TODO: implement buildTableSummaryCellWidget
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Text(summaryValue!,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white70)),
    );
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: cardBackgroundColor,
        cells: row.getCells().map<Widget>((e) {
          TextStyle getTextStyle() {
            if (e.columnName == 'goals_scored') {
              return TextStyle(
                  color: goalsScoredTextColor,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic);
            }
            if (e.columnName == 'player_name') {
              return const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontStyle: FontStyle.normal);
            } else if (e.columnName == 'nationality') {
              return const TextStyle(
                  color: Colors.white, fontStyle: FontStyle.italic);
            } else {
              return const TextStyle(color: Colors.white);
            }
          }

          return e.columnName == 'image'
              ? Builder(builder: (context) {
                  FirstTeamClassNotifier firstTeamClassNotifier =
                      Provider.of<FirstTeamClassNotifier>(context);
                  SecondTeamClassNotifier secondTeamClassNotifier =
                      Provider.of<SecondTeamClassNotifier>(context);
                  return GestureDetector(
                    onTap: () {
                      /// DG to PP
                      String playerName = row
                          .getCells()
                          .firstWhere(
                              (element) => element.columnName == 'player_name')
                          .value
                          .toString();

                      var firstTeamPlayer = firstTeamClassNotifier
                          .firstTeamClassList
                          .firstWhereOrNull(
                              (element) => element.name == playerName);

                      var secondTeamPlayer = secondTeamClassNotifier
                          .secondTeamClassList
                          .firstWhereOrNull(
                              (element) => element.name == playerName);

                      if (firstTeamPlayer != null) {
                        firstTeamClassNotifier.currentFirstTeamClass =
                            firstTeamPlayer;
                        navigateToSubPage(context);

                        Toast.show("Loading up $playerName",
                            duration: Toast.lengthLong,
                            gravity: Toast.bottom,
                            backgroundRadius: 10);
                      } else if (secondTeamPlayer != null) {
                        secondTeamClassNotifier.currentSecondTeamClass =
                            secondTeamPlayer;
                        navigateToSecondTeamClassDetailsPage(context);

                        Toast.show("Loading up $playerName",
                            duration: Toast.lengthLong,
                            gravity: Toast.bottom,
                            backgroundRadius: 10);
                      } else {
                        Toast.show("Ummmm, we can't find $playerName",
                            duration: Toast.lengthLong,
                            gravity: Toast.bottom,
                            backgroundRadius: 10);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      // width: 25,
                      // height: 25,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          // borderRadius: const BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              alignment: const Alignment(-1, -1.1),
                              image: CachedNetworkImageProvider(
                                e.value,
                              ),
                              fit: BoxFit.cover)),
                    ),
                  );
                })
              : e.columnName == 'player_name'
                  ? Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e.value.toString(),
                        style: getTextStyle(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Container(
                      alignment: (e.columnName == 'id')
                          ? Alignment.center
                          : Alignment.centerLeft,
                      // alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e.value.toString(),
                        style: getTextStyle(),
                        overflow: TextOverflow.fade,
                      ),
                    );
        }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}

class PlayersTable {
  // int? id;
  String? id;
  String? image;
  String? playerName;
  int? matchesPlayed;
  int? matchesStarted;
  int? matchesBenched;
  int? goalsScored;
  int? assists;
  String? playerPosition;
  int? yellowCard;
  int? redCard;
  String? nationality;

  PlayersTable(
      {this.id,
      this.image,
      this.playerName,
      this.matchesPlayed,
      this.matchesStarted,
      this.matchesBenched,
      this.goalsScored,
      this.assists,
      this.playerPosition,
      this.yellowCard,
      this.redCard,
      this.nationality});
}

Future navigateToSubPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SubPage()));
}

Future navigateToSecondTeamClassDetailsPage(context) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SecondTeamClassDetailsPage()));
}
