import 'dart:math';
import 'package:coventry_phoenix_fc/notifier/past_matches_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../api/past_matches_api.dart';

class PastMatchesPage extends StatefulWidget {
  const PastMatchesPage({super.key});

  @override
  _PastMatchesPageState createState() => _PastMatchesPageState();
}

DateTime now = DateTime.now();
// DateTime date = DateTime(now.day, now.month, now.year);
var matchDate = DateFormat('EEEE').format(now);

class _PastMatchesPageState extends State<PastMatchesPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;

  @override
  void initState() {
    PastMatchesNotifier pastMatchesNotifier =
        Provider.of<PastMatchesNotifier>(context, listen: false);
    getPastMatches(pastMatchesNotifier);

    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    _color =
        ColorTween(begin: Colors.blue, end: Colors.amber).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PastMatchesNotifier pastMatchesNotifier =
    Provider.of<PastMatchesNotifier>(context);

    return Scaffold(
      body: AnimatedBuilder(
        animation: _color,
        builder: (BuildContext _, Widget? __) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration:
                BoxDecoration(color: _color.value, shape: BoxShape.rectangle),
            child: ListView.builder(
                itemBuilder:  (BuildContext context, int index) {
                  return const AnimCard(
                    Color(0xffFF6594),
                    '',
                    '',
                    '',
                  );
          },
              itemCount: pastMatchesNotifier.pastMatchesList.length,
            ),
          );
        },
      ),
    );
  }
}

class AnimCard extends StatefulWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;

  const AnimCard(this.color, this.num, this.numEng, this.content, {super.key});

  @override
  _AnimCardState createState() => _AnimCardState();
}

class _AnimCardState extends State<AnimCard> {
  var padding = 0.0;
  var bottomPadding = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPadding(
          padding: EdgeInsets.only(top: padding, bottom: bottomPadding),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
          child: CardItem(
            widget.color,
            widget.num,
            widget.numEng,
            widget.content,
            () {
              setState(() {
                padding = padding == 10 ? 120.0 : 0.0;
                bottomPadding = bottomPadding == 0 ? 120 : 0.0;
              });
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 10, left: 10, top: 40),
            height: 90,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30)
              ],
              color: Colors.grey.shade200.withOpacity(1.0),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30, bottom: 5),
                        height: 55,
                        width: 53,
                        decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Center(
                          child: Icon(Icons.favorite,
                              color: const Color(0xffFF6594).withOpacity(1.0),
                              size: 40),
                        ),
                      ),
                      Container(
                        width: 130,
                        margin: const EdgeInsets.only(left: 7),
                        child: const Text(
                          'Coventry Phoenix Ist',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('13-02-2023 14:00',
                        style: TextStyle(
                          fontSize: 10,
                        )),
                    // const SizedBox(
                    //   height:20
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        // Icon(Icons.favorite,
                        //     color: const Color(0xffFF6594).withOpacity(1.0), size: 70),
                        Text('3',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500)),
                        Text('-',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500)),
                        Text(
                          '1',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                )),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 30, bottom: 5),
                        height: 55,
                        width: 53,
                        decoration: const BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Center(
                          child: Icon(Icons.favorite,
                              color: const Color(0xffFF6594).withOpacity(1.0),
                              size: 40),
                        ),
                      ),
                      Container(
                        width: 130,
                        margin: const EdgeInsets.only(right: 15),
                        child: const Text(
                          '          Gxng FC',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardItem extends StatefulWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;
  final onTap;

  const CardItem(this.color, this.num, this.numEng, this.content, this.onTap,
      {super.key});

  // @override
  // Widget build(BuildContext context) {
  //   double width = MediaQuery.of(context).size.width;
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 15),
  //       height: 90,
  //       width: width,
  //       decoration: BoxDecoration(
  //         boxShadow: [
  //           BoxShadow(
  //               color: const Color(0xffFF6594).withOpacity(0.2),
  //               blurRadius: 25),
  //         ],
  //         color: color.withOpacity(1.0),
  //         borderRadius: const BorderRadius.only(
  //           topLeft: Radius.circular(15),
  //           topRight: Radius.circular(15),
  //         ),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(5.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             const Text(
  //               'Tap to view more',
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w600),
  //             ),
  //             const SizedBox(
  //               height: 8,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: const [
  //                 Flexible(
  //                   child: Text(
  //                     'Goals Scorers: Goal Scorers, Goal Scorers, Goal Scorers, Goal Scorers, Goal Scorers',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                     textAlign: TextAlign.start,
  //                     overflow: TextOverflow.fade,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 30,
  //                 ),
  //                 Flexible(
  //                   child: Text(
  //                     "Assists: Assists, Assists, Assists, Assists, Assists, Assists, Assists, Assists",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                     textAlign: TextAlign.end,
  //                     overflow: TextOverflow.fade,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        height: 90,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color(0xffFF6594).withOpacity(0.2),
                blurRadius: 25),
          ],
          color: widget.color.withOpacity(1.0),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Tap to view more',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Flexible(
                    child: Text(
                      'Goals Scorers: Goal Scorers, Goal Scorers, Goal Scorers, Goal Scorers, Goal Scorers',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: Text(
                      "Assists: Assists, Assists, Assists, Assists, Assists, Assists, Assists, Assists",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
