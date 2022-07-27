// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../main.dart';


Color colorBack = const Color.fromRGBO(58, 56, 69, 1);
Color? appBarColor = const Color.fromRGBO(136, 121, 176, 1);

// dynamic coachesPopulation;
// dynamic nonCoachesPopulation;
// dynamic malePlayersPopulation = attackingPlayersPopulation + midfieldingPlayersPopulation + defendingPlayersPopulation + goalkeepingPlayersPopulation;
// dynamic femalePlayersPopulation;
// dynamic graduatedPlayersPopulation;
// dynamic attackingPlayersPopulation;
// dynamic midfieldingPlayersPopulation;
// dynamic defendingPlayersPopulation;
// dynamic goalkeepingPlayersPopulation;
// dynamic totalPlayersPopulation = malePlayersPopulation + femalePlayersPopulation;

class SeasonTimeline extends StatefulWidget {
  const SeasonTimeline({Key? key}) : super(key: key);

  @override
  State<SeasonTimeline> createState() => _SeasonTimelineState();
}

class _SeasonTimelineState extends State<SeasonTimeline> {

  late TooltipBehavior _tooltipBehavior;
  late TooltipBehavior _tooltipBehaviorTwo;

  final double _pointerValue = 32;
  String _image = 'assets/images/baller.gif';

  @override
  Widget build(BuildContext context) {
    final List<PlayersPopulationChartData> playersPopulationChartData = [
      PlayersPopulationChartData('Attackers', 16),
      PlayersPopulationChartData('Midfielders', 35),
      PlayersPopulationChartData('Defenders', 19),
      PlayersPopulationChartData('GoalKeepers', 7)
    ];

    // return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    //   stream: FirebaseFirestore.instance.collection('ClubPopulation')
    //       .doc('about_club_page').snapshots(),
    //   builder: (context, snapshot) {
    //     coachesPopulation = snapshot.data!.data()!['coaches_population'];
    //     nonCoachesPopulation = snapshot.data!.data()!['non_coaches_population'];
    //     // malePlayersPopulation = snapshot.data!.data()!['male_players_population'];
    //     femalePlayersPopulation = snapshot.data!.data()!['female_players_population'];
    //     graduatedPlayersPopulation = snapshot.data!.data()!['graduated_players_population'];
    //     attackingPlayersPopulation = snapshot.data!.data()!['attacking_male_players_population'];
    //     midfieldingPlayersPopulation = snapshot.data!.data()!['midfielding_male_players_population'];
    //     defendingPlayersPopulation = snapshot.data!.data()!['defending_male_players_population'];
    //     goalkeepingPlayersPopulation = snapshot.data!.data()!['goalkeepers_male_players_population'];

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('This Page Is Beta/Dummy 👀🧡',
                style: TextStyle(
                    color: Color(0xffB1BCE6)
                )
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: appBarIconColor),
              onPressed: () {
                // Navigator.of(context).pop(false);
                navigateMyApp(context);
              },
            ),
            elevation: 10,
            backgroundColor: colorBack,
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/timeline_back.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
              child: SingleChildScrollView(
                child: SafeArea(
                  top: true,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: BlurryContainer(
                          color: Colors.indigo.withOpacity(0.75),
                          blur: 1,
                          elevation: 16,
                          height: 300,
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Last 7 Matches | Win-Draw-Loss Chart',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  )),

                              SfSparkWinLossChart(
                                axisLineColor: Colors.white,
                                color: Colors.blue,
                                negativePointColor: Colors.red.withOpacity(0.75),
                                tiePointColor: Colors.black,
                                trackball: const SparkChartTrackball(
                                  color: Colors.indigoAccent,
                                  backgroundColor: Colors.indigoAccent,
                                  activationMode: SparkChartActivationMode.tap
                                ),
                                data: const <double>[
                                  2.1, 3.1, -2.4, 5.3, 0.0, 4.2, -1.3
                                ],
                              ),
                            ],
                          ),

                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: BlurryContainer(
                          color: Colors.blue.withOpacity(0.85),
                          blur: 1,
                          elevation: 16,
                          height: 450,
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Average Monthly Training Attendance Chart',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                  )
                              ),
                              SfCartesianChart(
                                margin: const EdgeInsets.all(20),
                                borderWidth: 2,
                                borderColor: Colors.white,
                                plotAreaBorderColor: Colors.white,
                                plotAreaBorderWidth: 0,
                                tooltipBehavior: _tooltipBehaviorTwo,
                                enableAxisAnimation: true,
                                legend: Legend(
                                  textStyle: const TextStyle(
                                    color: Colors.white
                                  ),
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                  toggleSeriesVisibility: true
                                ),
                                primaryXAxis: CategoryAxis(
                                  rangePadding: ChartRangePadding.none,
                                  labelStyle: const TextStyle(
                                    color: Colors.white
                                  )
                                ),
                                primaryYAxis: CategoryAxis(
                                    rangePadding: ChartRangePadding.none,
                                    labelStyle: const TextStyle(
                                        color: Colors.white
                                    ),
                                ),
                                series: <ChartSeries>[
                                  SplineSeries<TrainingAttendanceChartData, String>(
                                    animationDuration: 9000,
                                    color: Colors.white,
                                    name: 'Last 5 months',
                                    enableTooltip: true,
                                    dataSource: [
                                      TrainingAttendanceChartData('June', 25),
                                      TrainingAttendanceChartData('July', 40),
                                      TrainingAttendanceChartData('Aug', 33),
                                      TrainingAttendanceChartData('Sept', 51),
                                      TrainingAttendanceChartData('Oct', 39),
                                    ],
                                    xValueMapper: (TrainingAttendanceChartData data, _) => data.x,
                                    yValueMapper: (TrainingAttendanceChartData data, _) => data.y,
                                    markerSettings: const MarkerSettings(
                                        isVisible: true,
                                      shape: DataMarkerType.triangle
                                    ),
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true,
                                      useSeriesColor: true
                                    ),
                                    dashArray: const <double>[5,5]
                                  )
                                ],
                              )
                            ],
                          ),

                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: BlurryContainer(
                          color: Colors.white.withOpacity(0.95),
                          blur: 1,
                          elevation: 16,
                          height: 500,
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Club's Monthly Efficiency | Evaluation Gauge")),

                              SfRadialGauge(
                                enableLoadingAnimation: true,
                                animationDuration: 7000,
                                axes: <RadialAxis>[
                                  RadialAxis(
                                    labelFormat: '{value}%',
                                    minimum: 0,
                                    maximum: 100,
                                    maximumLabels: 5,
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                        startValue: 0,
                                        endValue: 33,
                                        color: Colors.green,
                                        startWidth: 10,
                                        endWidth: 10,
                                      ),
                                      GaugeRange(
                                        startValue: 33,
                                        endValue: 67,
                                        color: Colors.orange,
                                        startWidth: 10,
                                        endWidth: 10,
                                      ),
                                      GaugeRange(
                                        startValue: 67,
                                        endValue: 100,
                                        color: Colors.red,
                                        startWidth: 10,
                                        endWidth: 10,
                                      ),
                                    ],
                                    pointers: const <GaugePointer>[NeedlePointer(
                                      value: 87,
                                    )],
                                    annotations: const <GaugeAnnotation>[
                                      GaugeAnnotation(
                                        angle: 90,
                                          positionFactor: 0.5,
                                          widget: Text(
                                            '87%',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              fontSize: 20
                                            ),
                                          )
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Text(
                                'July 2022   💪🏼',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic
                                ),
                              )
                            ],
                          ),

                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: BlurryContainer(
                          color: Colors.redAccent.withOpacity(0.75),
                          blur: 1,
                          elevation: 16,
                          height: 400,
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Special Match/Event Counter",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                              const SizedBox(height: 20),

                              SfLinearGauge(
                                labelFormatterCallback: (label) {
                                  if (label == '45') {
                                    return 'Event Day';
                                  }
                                  return label;
                                },
                                axisLabelStyle: const TextStyle(
                                    color: Colors.white
                                ),
                                maximum: 45,
                                interval: 45,
                                animateAxis: true,
                                minorTicksPerInterval: 0,
                                axisTrackStyle: LinearAxisTrackStyle(
                                    thickness: 32,
                                    edgeStyle: LinearEdgeStyle.bothCurve,
                                    borderWidth: 1,
                                    borderColor: Colors.grey[350],
                                    color: Colors.blueGrey.withOpacity(0.65)
                                ),
                                barPointers: <LinearBarPointer>[
                                  LinearBarPointer(
                                    value: _pointerValue,
                                    animationDuration: 20000,
                                    thickness: 32,
                                    color: Colors.white.withOpacity(0.85),
                                  ),
                                  const LinearBarPointer(
                                    value: 45,
                                    animationDuration: 20000,
                                    thickness: 32,
                                    offset: 40,
                                    color: Colors.transparent,
                                    position: LinearElementPosition.outside,
                                    child: Text('Saturday, 2 July | Presentation Night',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                                markerPointers: <LinearMarkerPointer>[
                                  LinearWidgetPointer(
                                      value: _pointerValue,
                                      animationDuration: 20000,
                                      onAnimationCompleted: () {
                                        setState(() {
                                          _image = 'assets/images/baller.png';
                                        });
                                      },
                                      position: LinearElementPosition.outside,
                                      child: SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: Image.asset(
                                          _image,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                  )
                                ],

                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text(
                                    'Days Left',
                                    style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    '12',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),

                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: BlurryContainer(
                          color: Colors.teal.withOpacity(0.45),
                          blur: 1,
                          elevation: 16,
                          height: 400,
                          padding: const EdgeInsets.all(32),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Total Players Population Chart',
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    )),
                                SfCircularChart(
                                  tooltipBehavior: _tooltipBehavior,
                                  legend: Legend(
                                    alignment: ChartAlignment.center,
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    isResponsive: true,
                                    isVisible: true,
                                    position: LegendPosition.bottom,
                                    textStyle: const TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                                  palette: [
                                    Colors.teal, Colors.indigo.shade600, Colors.blueAccent, Colors.redAccent
                                  ],
                                  series: <CircularSeries>[
                                    PieSeries<PlayersPopulationChartData, String>(
                                      enableTooltip: true,
                                      dataSource: playersPopulationChartData,
                                      xValueMapper: (PlayersPopulationChartData data, _) => data.x,
                                      yValueMapper: (PlayersPopulationChartData data, _) => data.y,
                                      dataLabelSettings: const DataLabelSettings(
                                        useSeriesColor: true,
                                        isVisible: true,
                                        labelPosition: ChartDataLabelPosition.outside,
                                        labelIntersectAction: LabelIntersectAction.shift,
                                        connectorLineSettings: ConnectorLineSettings(
                                          type: ConnectorType.curve
                                        )
                                      ),
                                      explode: true,
                                      animationDuration: 9000,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                    ],
                  ),
                ),
              ),
          ),
        );
      // }
    // );

  }


  Future navigateMyApp(context) async {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
    Navigator.of(context).pop(false);
  }

  @override
  void initState() {
    _tooltipBehavior =  TooltipBehavior(
        enable: true,
        color: Colors.teal
    );

    _tooltipBehaviorTwo =  TooltipBehavior(
        enable: true,
        color: Colors.lightBlue
    );

    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }


  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('images/baller.png'), context);
    super.didChangeDependencies();
  }
}

class TrainingAttendanceChartData {
  TrainingAttendanceChartData(this.x, this.y);
  final String x;
  final double? y;
}

class PlayersPopulationChartData {
  PlayersPopulationChartData(this.x, this.y, [this.color]);
  final String x;
  // dynamic y;
  int y;
  final Color? color;
}
