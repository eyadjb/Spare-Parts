// ignore_for_file: avoid_print, deprecated_member_use, use_rethrow_when_possible

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
    return null;
  }

  // Update user email
  Future<void> updateUserEmail(String newEmail) async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser!.updateEmail(newEmail);
        print('User email updated successfully');
      }
    } catch (e) {
      print('Failed to update user email: $e');
      throw e;
    }
  }
}
