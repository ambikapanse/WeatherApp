import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/home.dart';
import 'Screens/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      // Set fullscreen
    home: const Splash(),
    routes: {
      "/home" : (context) => const Home(),
      "/splash" : (context) => const Splash()


    },
  ));
}

