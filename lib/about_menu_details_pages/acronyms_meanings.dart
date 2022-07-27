import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String clubName = "Coventry Phoenix FC";
String acronymTitle = "Acronym Meanings";
String acronym = "The following acronym(s) are used in the apps and their meanings are detailed.";
String icdat = "ICDAT - I Can Do All Things\n\n";
String cpfc = "CPFC - Coventry Phoenix FC\n\n";
String apt = "A.P.T. - All Players Table\n\n";
String id = "ID - Identification\n\n";
String mp = "MP - Matches Played\n\n";
String gs = "GS - Goals Scored\n\n";
String a = "A - Assists\n\n";
String yc = "YC - Yellow Cards\n\n";
String rc = "RC - Red Cards\n\n";
String pp = "PP - Players Positions\n\n";
String fc = "FC - Football Club\n\n";
String motm = "MOTM - Man Of The Match\n\n";
String potm = "POTM - Player Of The Match\n\n";
String cb = "CB - Center Back\n\n";
String lb = "LB - Left Back\n\n";
String rb = "RB - Right Back\n\n";
String gk = "GK - Goal Keeper\n\n";
String cm = "CM - Central Midfielder\n\n";
String cdm = "CDM - Central Defensive Midfielder\n\n";
String lm = "LM - Left Midfielder\n\n";
String rm = "RM - Right Midfielder\n\n";
String am = "AM - Attacking Midfielder\n\n";
String lw = "LW - Left Winger\n\n";
String rw = "RW - Right Winger\n\n";
String cf = "CF - Center Forward\n\n";
String goalsConceded = "Goals Con. - Goals Conceded\n\n";
String stars = "** - Flawed or Not Accurate Info\n\n";



Color backgroundColor = const Color.fromRGBO(58, 31, 41, 1);
Color appBarTextColor = Colors.white;
Color appBarBackgroundColor = const Color.fromRGBO(52, 18, 30, 1);
Color appBarIconColor = Colors.white;
Color cardBackgroundColor = const Color.fromRGBO(52, 18, 30, 1);
Color headingCardColor = Colors.white;
Color headingCardTextColor = const Color.fromRGBO(58, 31, 41, 1);
Color cardTextColor = Colors.white;

class AcronymsMeanings extends StatefulWidget {
  const AcronymsMeanings({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<AcronymsMeanings> createState() => _AcronymsMeaningsState();
}

class _AcronymsMeaningsState extends State<AcronymsMeanings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          acronymTitle,
          style: TextStyle(color: appBarTextColor),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: appBarBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: appBarIconColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
                elevation: 10,
                margin: const EdgeInsets.all(20),
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance.collection('SliversPages').doc('non_slivers_pages').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return Container(
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                snapshot.data?.data()!['acronyms_page'],
                              ),
                              fit: BoxFit.cover
                          )
                      ),
                    );
                  },
                )
            ),
            Card(
              margin: const EdgeInsets.all(20),
              color: cardBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Card(
                        color: headingCardColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 30, right: 30),
                          child: Text(
                            acronymTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontStyle: FontStyle.italic,
                                color: headingCardTextColor
                                    .withAlpha(220),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 30),
                    child: Column(
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '$acronym\n\n\n',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: icdat,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: cpfc,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: apt,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: id,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: mp,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: gs,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: a,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: yc,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: rc,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: pp,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: fc,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: motm,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: potm,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: cb,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: lb,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: rb,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: gk,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: cm,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: cdm,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: lm,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: rm,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: am,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: lw,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: rw,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: cf,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: goalsConceded,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: cardTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
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
}
