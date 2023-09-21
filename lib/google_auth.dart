import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuth {
  Future<UserCredential?> googleSignIn() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signOut().then((_) {
      return GoogleSignIn().signIn();
    });

    if (googleUser == null) {
      // The user canceled the sign-in process
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
