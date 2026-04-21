import 'package:firebase_auth/firebase_auth.dart';
import 'package:semur/config/application.dart';

class AuthService {
  signIn(PhoneAuthCredential authCredential) {
    try {
      Future<UserCredential> res =
          FirebaseAuth.instance.signInWithCredential(authCredential);

      return res;
    } catch (e) {
      Application.firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'status': 'not logged in',
      });
      return null;
    }
  }

  signInWithOTP(smsCode, verId) {
    try {
      PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: smsCode,
      );
      UserCredential res = signIn(authCredential);
      return res;
    } catch (e) {
      return null;
    }
  }

  signUpWithEmail(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return 'Failed to sign up.';
    }
  }

  signInWithEmail(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }
}
