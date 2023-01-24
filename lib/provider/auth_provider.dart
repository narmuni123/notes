import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

enum MenuAction { logout }

class AuthProvider extends ChangeNotifier {
  Future<bool> registration(
      {required context,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        if (kDebugMode) {
          print("weak password");
        }
      } else if (e.code == "email-already-in-use") {
        if (kDebugMode) {
          print("Email is already in use");
        }
      } else if (e.code == "invalid-email") {
        if (kDebugMode) {
          print("invalid email");
        }
      }
      notifyListeners();
      return false;
    }
  }

  Future<bool> singIn(
      {required context,
      required String email,
      required String password}) async {
    try {
      final value = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print(value);
      }
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        if (kDebugMode) {
          print("User not found");
        }
      } else if (e.code == "wrong-password") {
        if (kDebugMode) {
          print("Wrong password");
        }
      }
      notifyListeners();
      return false;
    }
  }

  Future logout({required context}) async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
    notifyListeners();
  }
}
