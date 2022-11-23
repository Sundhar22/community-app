import 'package:firebase_auth/firebase_auth.dart';
import 'package:microsoft/service/database_service.dart';

import '../helper/helper_fun.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// sign in

  Future loginUserNameWithEmailAndPassword(
      String password, String email) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

// sign up

  Future registerUserWithEmailAndPassword(
      String name, String password, String email) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        await DataBaseService(uid: user.uid).updateUserData(name, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // sign out

  Future signOut() async {
    try {
      await Helper.setUserLoggedInStatus(false);
      await Helper.setUserEmailInStatus('');
      await Helper.setUserNameInStatus('');
      firebaseAuth.signOut();
    } catch (e) {
      return e;
    }
  }
}
