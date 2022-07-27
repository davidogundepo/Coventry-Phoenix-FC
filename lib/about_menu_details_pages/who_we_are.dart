import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String elite = "Elite";
String graduateSetTheme = "ELITE Set 2022";
String graduateSetThemeTitle = "We Are ELITE";
String whoWeAre = "Who We Are";


String whoVerse = "The Question\nThey ask us\nWho are we?\nThe world has set its standards\nBut we use a different curriculum\nWe don't fit anywhere";
String weVerse = "Whose name do we carry?\nWhose voice do we hear?\nWhose footsteps do we follow\nThat marks us as chosen\nAnd names us as blessed";
String areVerse = "We are sent with a higher calling\nTo live eternally\nAnd lead others to the light\nWe may be few\nBut we are a formidable army\n";
String eliteVerse = "This is where we fit into\nOur world not of this world\nWe are chosen\nWe are Christians\nWe are ELITE";
String poet = 'Ayoade Iyanuoluwa';
String setVerse = "The word 'elite' is a noun drawn from the Latin word 'eligere' which means to pick out or select. Elite is used to refer to a small group of powerful people that controls an unequal amount of wealth, privilege, political power or skill in a society.\nAn elite is also defined by education (preferably Ivy League and it's coastal counterparts), profession (executive positions in government, media, law, foundations, the arts and academia), celebrity (name recognition from television, Hollywood, network news, finance, etc.) and ideology such as those prominent in the progressive movement.\nThe Elites holds a superior position among the ordinary people and exercise greater privilege, they are looked up to in the society as source of solution to any form of challenge.\nThis defines the personality of every  player of 2022 that has undergone training and tutorship on the core values rightly spelt out as; Spirituality, Integrity, Possibility Mentality, Capacity Building, Responsibility and Diligence.\nWe are a people with an extra ordinary ability to showcase to our generation in all ramifications of life. We have been reformed, transformed and informed of our dignity an prestige to the black race.\nThe players for 2022 are modelled after the order of our saviour Jesus Christ as reflected in 1 Peter 2:9, 'But you are a chosen race, a royal priesthood, an holy nation, a peculiar people; that ye should show forth the praises of him who hath called you out of darkness into his marvellous light...'. We are equipped to engage in who we are as Kings and Queens by reason of the DNA we possess from our heavenly Father the Kings of kings.\nWe are by authority and training, persons separated to be in the high class of our society here on earth.";
String core = 'Our core mission is:';
String coreOne = '1. To be a solution providers by adding value and creativity to changing the mirage of our society today.';
String coreTwo = "2. To be leaders who are not just breadwinners, job creators and world changers, but also God's Kingdom passionate lovers.";
String coreThree = "3. To be an army of reformers who shall redeem the battered image of the black race and restore her lost glory as we begin to build the old waste, repair the wasted cities and raise the desolation of many generations as pathfinders;";
String bottomLine = "It was C. Wright Mills (1956), an American sociologist who stated in his work titled 'The Power Elite' the need for a breed of Leaders that are value driven.";


Color backgroundColor = const Color.fromRGBO(15, 65, 79, 1);
Color appBarTextColor = Colors.white;
Color appBarBackgroundColor = const Color.fromRGBO(52, 18, 30, 1);
Color appBarIconColor = Colors.white;
Color cardBackgroundColor = const Color.fromRGBO(52, 18, 30, 1);
Color headingCardColor = Colors.white;
Color headingCardTextColor = const Color.fromRGBO(15, 65, 79, 1);
Color cardTextColor = Colors.greenAccent;
Color cardTextColorTwo = Colors.white;


class WhoWeAre extends StatefulWidget {
  const WhoWeAre({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<WhoWeAre> createState() => _WhoWeAreState();
}

class _WhoWeAreState extends State<WhoWeAre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          graduateSetThemeTitle,
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
                              snapshot.data?.data()!['who_we_are_page'],
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        child: Card(
                          color: headingCardColor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 30, right: 30),
                            child: Text(
                              whoWeAre,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                color: headingCardTextColor,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '$whoVerse\n\n\n',
                            style: TextStyle(
                              fontSize: 14,
                              color: cardTextColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: '$weVerse\n\n\n',
                            style: TextStyle(
                              fontSize: 14,
                              color: cardTextColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: '$areVerse\n\n',
                            style: TextStyle(
                              fontSize: 14,
                              color: cardTextColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: '$eliteVerse\n\n\n',
                            style: TextStyle(
                              fontSize: 14,
                              color: cardTextColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30, right: 10),
                        child: Text(poet,
                          style: TextStyle(
                            fontSize: 17,
                            color: cardTextColorTwo,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
