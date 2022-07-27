
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api/trainings_games_reels_api.dart';
import '../notifier/trainings_games_reels_notifier.dart';
import'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../main.dart';
import 'package:line_icons/line_icons.dart';



late TrainingsAndGamesReelsNotifier trainingsAndGamesReelsNotifier;

class TrainingsAndGamesReelsPage extends StatelessWidget implements PreferredSizeWidget {

  final ScrollController _scrollController = ScrollController();

  @override
  final Size preferredSize;

  TrainingsAndGamesReelsPage(
      {Key? key})
      : preferredSize = const Size.fromHeight(60.0), super(key: key);

  @override
  Widget build(BuildContext context) {
    trainingsAndGamesReelsNotifier = Provider.of<TrainingsAndGamesReelsNotifier>(context);
    getTrainingsAndGamesReels(trainingsAndGamesReelsNotifier);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 36, 48, 1),
      body: SafeArea(
        child: Stack(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(8.0),
                child: StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  itemCount: trainingsAndGamesReelsNotifier.trainingsAndGamesReelsList.length,
                  itemBuilder: _buildReels,
                  staggeredTileBuilder: (int index) {
                    return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                    },
                ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Hero(
                    tag: 'trainingsAndGamesReelsPageButton',
                    child: Card(
                      color: const Color.fromRGBO(27, 36, 48, 1),
                      elevation: 10,
                      shape: kBackButtonShape,
                      child: InkWell(
                        highlightColor: const Color.fromRGBO(255, 141, 41, 0.7).withAlpha(90),
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(30)),
                        onTap: (){navigateMyApp(context);},
                        child: IconButton(
                          alignment: Alignment.center,
                          splashColor: const Color.fromRGBO(255, 141, 41, 0.7),
                          splashRadius: 80,
                          color: const Color.fromRGBO(255, 141, 41, 0.7),
                          icon: InkWell(
                              highlightColor: const Color.fromRGBO(255, 141, 41, 0.7),
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(15)),
                              onTap: (){
                                // Navigator.of(context).pop(false);
                                navigateMyApp(context);
                              },
                              child: const Icon(LineIcons.chevronCircleLeft)),
                          iconSize: 30,
                          onPressed: () {
                            // Navigator.of(context).pop(false);
                            navigateMyApp(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 50,
                  // ),
                  Hero(
                    tag: 'title',
                    transitionOnUserGestures: true,
                    child: Card(
                      color: const Color.fromRGBO(27, 36, 48, 1),
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                          ),

                        ),
                        child: InkWell(
                          highlightColor: const Color.fromRGBO(255, 141, 41, 0.7).withAlpha(90),
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30)),
                          onTap: (){},
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 50,
                            child: const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  'Monthly Reels',//ADD FOOTBALL ICON
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Color.fromRGBO(255, 141, 41, 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future navigateMyApp(context) async {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
    Navigator.of(context).pop(false);
  }


  Widget _buildReels(BuildContext context, int index) {

    return Container(
      decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: const Color.fromRGBO(255, 141, 41, 1),
            width: 2
          ),
        ),
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                alignment: const Alignment(0, -1),
                image: CachedNetworkImageProvider(
                    (trainingsAndGamesReelsNotifier.trainingsAndGamesReelsList[index].image)!
                ),
                fit: BoxFit.cover
            )
        ),
        child: InkWell(
          onTap: () {},
          highlightColor: const Color.fromRGBO(255, 141, 41, 0.7).withAlpha(90),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

}

ShapeBorder kBackButtonShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
  ),
);




