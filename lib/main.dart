import 'package:flutter/material.dart';
import './screens/main_screen.dart';

enum PlayerState { stopped, playing, paused }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: MainScreen(),
      ),
    );
  }
}
