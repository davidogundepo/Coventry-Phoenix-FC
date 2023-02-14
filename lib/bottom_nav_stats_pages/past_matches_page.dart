import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coventry_phoenix_fc/notifier/past_matches_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    _color = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(_controller);
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
            padding: const EdgeInsets.only(bottom: 5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration:
                BoxDecoration(color: _color.value, shape: BoxShape.rectangle),
            child: SafeArea(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return AnimCard(
                    const Color.fromRGBO(98, 103, 112, 1.0),
                    '',
                    '',
                    '',
                    index: index,

                  );
                },
                itemCount: pastMatchesNotifier.pastMatchesList.length,
              ),
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
  final int index;
  final String numEng;
  final String content;

  const AnimCard(this.color, this.num, this.numEng, this.content, {super.key, required this.index});

  @override
  _AnimCardState createState() => _AnimCardState();
}

class _AnimCardState extends State<AnimCard> {
  var padding = 0.0;
  var bottomPadding = 0.0;

  @override
  Widget build(BuildContext context) {
    PastMatchesNotifier pastMatchesNotifier =
    Provider.of<PastMatchesNotifier>(context);

    return Column(
      children: [
        Stack(
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
                }, index: widget.index,
                // }, index: widget.index,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 10, left: 10, top: 40),
                height: 90,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2), blurRadius: 30)
                  ],
                  color: const Color.fromRGBO(57, 62, 70, 1),
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
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                            child: Center(
                              child: Container(
                                width: 42.0,
                                height: 42.0,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  // shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            pastMatchesNotifier.pastMatchesList[widget.index].homeTeamIcon!),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          Container(
                            width: 140,
                            margin: const EdgeInsets.only(left: 7),
                            child: Text(
                              pastMatchesNotifier.pastMatchesList[widget.index].homeTeam!,
                              style: GoogleFonts.allertaStencil(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w300),
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
                        Text(pastMatchesNotifier.pastMatchesList[widget.index].matchDate!,
                            style: GoogleFonts.electrolize(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: Colors.white54,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(pastMatchesNotifier.pastMatchesList[widget.index].homeTeamScore!,
                                style: GoogleFonts.jura(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                )),
                            Text('-',
                                style: GoogleFonts.jura(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                )),
                            Text(
                                pastMatchesNotifier.pastMatchesList[widget.index].awayTeamScore!,
                              style: GoogleFonts.jura(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
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
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                            child: Center(
                              child: Container(
                                width: 42.0,
                                height: 42.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    // shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            pastMatchesNotifier.pastMatchesList[widget.index].awayTeamIcon!),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          Container(
                            width: 140,
                            margin: const EdgeInsets.only(right: 15),
                            child: Text(
                              pastMatchesNotifier.pastMatchesList[widget.index].awayTeam!,
                              style: GoogleFonts.allertaStencil(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.end,
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
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class CardItem extends StatefulWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;
  final int index;
  final onTap;

  const CardItem(this.color, this.num, this.numEng, this.content, this.onTap,
      {super.key, required this.index});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    PastMatchesNotifier pastMatchesNotifier =
    Provider.of<PastMatchesNotifier>(context);

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
              Text(
                'Tap to view more',
                style: GoogleFonts.ptMono(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      'Goal Scorer(s): ${pastMatchesNotifier.pastMatchesList[widget.index].goalsScorers!}',
                      style: GoogleFonts.saira(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: Text(
                      "Assists: ${pastMatchesNotifier.pastMatchesList[widget.index].assistsBy!}",
                      style: GoogleFonts.saira(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
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
