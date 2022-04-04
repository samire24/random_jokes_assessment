import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_jokes_assessment/joke_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const JokeScreen()));
  }

  initScreen(BuildContext context) {
    return Center(
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: const Center(
          child: SpinKitFadingCircle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
