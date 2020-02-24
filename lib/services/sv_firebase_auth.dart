import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'sv_firestore.dart';

class SvFirebaseAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> googleLogin() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) {
        return false;
      }
      AuthResult res = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(
          idToken: (await account.authentication).idToken,
          accessToken: (await account.authentication).accessToken,
        ),
      );

      if (res.user == null) {
        return false;
      }

      Map<String, dynamic> data = {
        'uid': res.user.uid,
        'email': res.user.email,
        'photoURL': res.user.photoUrl,
        'displayName': res.user.displayName,
        'creationTime': res.user.metadata.creationTime,
        'lastSignInTime': res.user.metadata.lastSignInTime,
        'lastSeen': DateTime.now()
      };

      SvFirestore().createWithCustomDoc('users', res.user.uid, data, true);

      return true;
    } catch (e) {
      print("Error logging with google");
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
  }
}
