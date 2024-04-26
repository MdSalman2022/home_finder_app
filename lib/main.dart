import 'package:flutter/material.dart';
import 'package:home_finder_app/home.dart';
import 'package:home_finder_app/shifting.dart';
import 'package:home_finder_app/splash.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/', // Add this if you want to specify a default route
    routes: {
      '/': (context) => SplashScreen(),
      '/listing': (context) => HomePage(),
      '/shifting': (context) => ShiftingPage(),
      '/decor': (context) => HomePage(),
      '/interior': (context) => HomePage(),
    },
  ));
}
