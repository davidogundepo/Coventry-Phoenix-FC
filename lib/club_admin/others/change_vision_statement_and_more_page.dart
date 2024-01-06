import 'package:flutter/material.dart';

import '../../bloc_navigation_bloc/navigation_bloc.dart';


Color backgroundColor = const Color.fromRGBO(187, 192, 195, 1.0);
Color appBarBackgroundColor = const Color.fromRGBO(48, 50, 74, 1.0);
Color appBarArrowColor = const Color.fromRGBO(187, 192, 195, 1.0);

class MyChangeVisionStatementAndMorePage extends StatefulWidget with NavigationStates {
  MyChangeVisionStatementAndMorePage({Key? key}) : super(key: key);

  @override
  State<MyChangeVisionStatementAndMorePage> createState() => MyChangeVisionStatementAndMorePageState();
}

class MyChangeVisionStatementAndMorePageState extends State<MyChangeVisionStatementAndMorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor,
        title: const Text(
          'Change Statements',
          style: TextStyle(color: Colors.white70),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: appBarArrowColor),
          onPressed: () {
            navigateMyApp(context);
          },
        ),
      ),
      body: Container(),
    );
  }
}

Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}