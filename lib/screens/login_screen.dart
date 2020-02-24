import 'package:flutter/material.dart';

import '../services/sv_firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Google Login"),
              onPressed: () {
                SvFirebaseAuth().googleLogin();
              },
            )
          ],
        ),
      ),
    );
  }
}
