import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../services/sv_firebase_auth.dart';

class DrawerX extends StatelessWidget {
  final FirebaseUser _user;

  DrawerX(this._user);
  @override
  Widget build(BuildContext context) {
    String _platform;
    if (kIsWeb) {
      _platform = "Platform is WEBSITE";
    } else {
      // Platform .isAndroid | .isIOS | .isFuchsia | .isLinux | .isMacOS | .isWindows
      if (Platform.isAndroid) {
        _platform = "Platform is ANDROID";
      } else if (Platform.isIOS) {
        _platform = "Platform is iOS";
      }
    }

    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_platform),
                CircleAvatar(
                  backgroundImage: NetworkImage(_user.photoUrl),
                  radius: 40.0,
                ),
                Text(_user.email),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              RaisedButton(
                child: Text("log out"),
                onPressed: () {
                  Navigator.pop(context);
                  SvFirebaseAuth().logout();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
