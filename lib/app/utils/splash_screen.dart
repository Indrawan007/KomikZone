import 'package:flutter/material.dart';

var Ungu = Color(0xff5B0D80);

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Ungu,
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
      ),
    );
  }
}
