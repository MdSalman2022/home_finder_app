import 'package:flutter/material.dart';
import 'package:home_finder_app/home.dart';
import 'package:home_finder_app/start.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});
  @override
  State<GetStarted> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<GetStarted> {
  // Widget? activeScreen;
  var activeScreen = 'start-screen';

  // @override
  // void initState() {
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }

  void switchScreen() {
    setState(() {
      // activeScreen = const QuestionsScreen();
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = HomePage();
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          // child: activeScreen,
          child: screenWidget,
        ),
      ),
    );
  }
}
