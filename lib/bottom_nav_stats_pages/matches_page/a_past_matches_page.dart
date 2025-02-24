import 'package:cached_network_image/cached_network_image.dart';
import './a_upcoming_matches_page.dart';
import '../../notifier/a_past_matches_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../api/a_past_matches_api.dart';


Color nabColor = const Color.fromRGBO(56, 56, 60, 1);
Color splashColorTwo = Colors.black87;

class PastMatchesPage extends StatefulWidget {
  const PastMatchesPage({super.key});

  @override
  PastMatchesPageState createState() => PastMatchesPageState();
}

class PastMatchesPageState extends State<PastMatchesPage>
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
        ColorTween(begin: Colors.black, end: Colors.white).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future navigateTablesAndStatsDetails(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UpcomingMatchesPage()));
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
              // ((){
              //
              // }()),

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

  const AnimCard(this.color, this.num, this.numEng, this.content,
      {super.key, required this.index});

  @override
  AnimCardState createState() => AnimCardState();
}

class AnimCardState extends State<AnimCard> {
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
                },
                index: widget.index,
                // }, index: widget.index,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(left: 10, top: 40, right: 10),
                height: 90,
                width: MediaQuery.of(context).size.width,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            pastMatchesNotifier
                                                .pastMatchesList[widget.index]
                                                .homeTeamIcon!),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            margin: const EdgeInsets.only(left: 7),
                            child: Text(
                              pastMatchesNotifier
                                  .pastMatchesList[widget.index].homeTeam!,
                              style: GoogleFonts.allertaStencil(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            pastMatchesNotifier
                                .pastMatchesList[widget.index].matchDate!,
                            style: GoogleFonts.electrolize(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: Colors.white54,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                pastMatchesNotifier
                                    .pastMatchesList[widget.index]
                                    .homeTeamScore!,
                                style: GoogleFonts.jura(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                )),
                            Text('-',
                                style: GoogleFonts.jura(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                )),
                            Text(
                              pastMatchesNotifier
                                  .pastMatchesList[widget.index].awayTeamScore!,
                              style: GoogleFonts.jura(
                                fontSize: 25,
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
                        // mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10, bottom: 5, top: 5),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            pastMatchesNotifier
                                                .pastMatchesList[widget.index]
                                                .awayTeamIcon!),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            padding: const EdgeInsets.only(right: 7),
                            child: Text(
                              pastMatchesNotifier
                                  .pastMatchesList[widget.index].awayTeam!,
                              overflow: TextOverflow.clip,
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
  final dynamic onTap;

  const CardItem(this.color, this.num, this.numEng, this.content, this.onTap,
      {super.key, required this.index});

  @override
  CardItemState createState() => CardItemState();
}

class CardItemState extends State<CardItem> {
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
                color: const Color(0xff667b80).withOpacity(0.2),
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
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black.withAlpha(40)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
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
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
