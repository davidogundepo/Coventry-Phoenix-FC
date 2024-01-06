import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

Color backgroundColor = const Color.fromRGBO(187, 192, 195, 1.0);

class MyDisplayRedCardHistoryPage extends StatefulWidget with NavigationStates {
  MyDisplayRedCardHistoryPage({Key? key}) : super(key: key);

  @override
  State<MyDisplayRedCardHistoryPage> createState() => MyDisplayRedCardHistoryPageState();
}

class MyDisplayRedCardHistoryPageState extends State<MyDisplayRedCardHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
