import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../api/trainings_games_reels_api.dart';
import '../notifier/trainings_games_reels_notifier.dart';

late TrainingsAndGamesReelsNotifier trainingsAndGamesReelsNotifier;

class TrainingsAndGamesReelsPage extends StatelessWidget implements PreferredSizeWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  final Size preferredSize;

  TrainingsAndGamesReelsPage({Key? key})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

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
              child: SingleChildScrollView(
                controller: _scrollController,
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  children: List.generate(
                    trainingsAndGamesReelsNotifier.trainingsAndGamesReelsList.length,
                        (index) {
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: index.isEven ? 1.2 : 1.8,
                        child: _buildReels(context, index),
                      );
                    },
                  ),
                ),
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
                        onTap: () {
                          navigateMyApp(context);
                        },
                        child: IconButton(
                          alignment: Alignment.center,
                          splashColor: const Color.fromRGBO(255, 141, 41, 0.7),
                          splashRadius: 80,
                          color: const Color.fromRGBO(255, 141, 41, 0.7),
                          icon: InkWell(
                              highlightColor: const Color.fromRGBO(255, 141, 41, 0.7),
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(15)),
                              onTap: () {
                                navigateMyApp(context);
                              },
                              child: const Icon(LineIcons.chevronCircleLeft)),
                          iconSize: 30,
                          onPressed: () {
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
                        onTap: () {},
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 50,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                'Monthly Photos', //ADD FOOTBALL ICON
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
    Navigator.of(context).pop(false);
  }

  Widget _buildReels(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: const Color.fromRGBO(255, 141, 41, 1), width: 2),
      ),
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                alignment: const Alignment(0, -1),
                image: CachedNetworkImageProvider((trainingsAndGamesReelsNotifier.trainingsAndGamesReelsList[index].image)!),
                fit: BoxFit.cover)),
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
