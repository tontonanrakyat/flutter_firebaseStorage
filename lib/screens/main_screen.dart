import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './splash_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return HomeScreen(snapshot.data);
          }
          return LoginScreen();
        }
      },
    );
  }
}
