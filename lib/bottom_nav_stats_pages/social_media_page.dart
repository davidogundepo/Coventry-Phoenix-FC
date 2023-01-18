
import 'package:flutter/material.dart';
import 'package:twitter_oembed_api/twitter_oembed_api.dart';
import 'dart:developer';
// import 'package:flutter_html/flutter_html.dart';


dynamic embeddedTimeline;


void main() async {
  final twitterApi = TwitterOEmbedApi();

  try {
    /// You can get the embedded tweet by specifying the tweet ID.
    // final embeddedTweet = await twitterApi.publishEmbeddedTweet(
    //   screenName: 'Interior',
    //   tweetId: '507185938620219395',
    //   maxWidth: 550,
    //   align: ContentAlign.center,
    // );
    //
    // // print(embeddedTweet.html);
    // log(embeddedTweet.html);

    /// You can get the embedded timeline by specifying the screen name,
    /// or with list name.


    embeddedTimeline = await twitterApi.publishEmbeddedTimeline(
      screenName: 'DavidOOludepo',
      // limit: 3,
      theme: ContentTheme.dark,
    );

    log(embeddedTimeline.html);


  } on TwitterOEmbedException catch (e) {
    print(e);
  }
}

class Hello extends StatefulWidget {
  const Hello({Key? key}) : super(key: key);

  @override
  State<Hello> createState() => _HelloState();


}

var htmlData = embeddedTimeline;

class _HelloState extends State<Hello> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // child: Html(
        //   data: htmlData,
        // ),
        child: Container(

        ),
      ),
    );
  }
}
