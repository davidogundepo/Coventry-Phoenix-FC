import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class YoutubePage extends StatefulWidget {
  const YoutubePage({Key? key}) : super(key: key);

  @override
  State<YoutubePage> createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  // YoutubePlayerController? _controller;

  late double width;
  late double height;


  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width * 0.7;
    height: MediaQuery.of(context).size.height * 0.55;

    return const Scaffold(
      // body: YoutubePlayerBuilder(
      //   player: YoutubePlayer(
      //     controller: _controller!,
      //     showVideoProgressIndicator: true,
      //     progressIndicatorColor: Colors.orange,
      //     progressColors: const ProgressBarColors(
      //       playedColor: Colors.orange,
      //       handleColor: Colors.orangeAccent
      //     ),
      //   ),
      //   builder: (context, player) {
      //     return Column(
      //       children: [
      //         player,
      //       ],
      //     );
      //   },
      // ),


    );
  }


  @override
  void initState() {
    super.initState();

    // _controller = YoutubePlayerController(
    //   initialVideoId: 'oLBbFgDOYZU',
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: false,
    //     mute: false,
    //   )
    // );
  }
}
