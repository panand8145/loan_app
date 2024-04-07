import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class AuthRepository {
  // LOGIN WITH [EMAIL & PASSWORD] ON FIREBASE CONSOLE
  Future<String> userLoginWithFirebase(
      {required String emailAddress, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (credential.user?.email != null) {
        await saveUserCredential(
            name: credential.user!.displayName ?? "",
            emailAddress: credential.user!.email!,
            password: credential.user!.uid);
      }
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // 'No user found for that email.'
        return "We couldn't find a user with that email address.";
      } else if (e.code == 'invalid-credential') {
        return "Invalid email address & password.";
      } else if (e.code == 'wrong-password') {
        // 'Wrong password provided for that user.'
        return "Please enter correct password";
      } else {
        return "Something went wrong.";
      }
    }
  }

  // REGISTER USER ACCOUNT ON FIREBASE AUTH
  Future<String> userRegistrationWithFirebase({required String name,
    required String emailAddress,
    required String password}) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await credential.user?.updateDisplayName(name);
      if (credential.user?.email != null) {
        await saveUserCredential(
            name: credential.user!.displayName ?? "",
            emailAddress: credential.user!.email!,
            password: credential.user!.uid);
      }
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Entered password is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "Account already exists for that email.";
      } else {
        return "Something went wrong.";
      }
    } catch (e) {
      print(e);
      return "Something went wrong.";
    }
  }

  // LOGOUT FROM APP
  Future<bool> userLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  // WE SAVE EMAIL ADDRESS AND PASSWORD INTO THE SHARED-PREFERENCE
  Future<void> saveUserCredential({required String name,
    required String emailAddress,
    required String password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUserName, name);
    await prefs.setString(keyEmail, emailAddress);
  }
}
