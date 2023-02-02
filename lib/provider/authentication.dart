import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/interactive_constant.dart';
import 'package:mynotes/constants/routes.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/services/auth/auth_services.dart';

class Authentication {
  // Registration call
  static Future<bool> registration(
      {required context,
      required String email,
      required String password}) async {
    try {
      await AuthServices.firebase().createUser(
        email: email,
        password: password,
      );
      await verifyEmail(context: context);
      Navigator.of(context).pushNamed(emailVerifyRoute);
      snackBar(context: context, title: "User created successfully");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        devtools.log("weak password");
        snackBar(context: context, title: "weak-password");
      } else if (e.code == "email-already-in-use") {
        devtools.log("Email is already in use");
        snackBar(context: context, title: "Email is already in use");
      } else if (e.code == "invalid-email") {
        devtools.log("invalid email");
        snackBar(context: context, title: "invalid-email");
      } else {
        devtools.log("Error : ${e.code}");
        snackBar(context: context, title: "Error : ${e.code}");
      }
      return false;
    }
  }

  // Sign in call
  static Future<bool> singIn(
      {required context,
      required String email,
      required String password}) async {
    try {
      final value = await AuthServices.firebase().login(
        email: email,
        password: password,
      );
      devtools.log(value.toString());
      final user = AuthServices.firebase().currentUser;
      if (user?.isEmailVerified ?? false) {
        snackBar(context: context, title: "Log in successful!!");
        Navigator.of(context)
            .pushNamedAndRemoveUntil(homeRoute, (route) => false);
      } else {
        snackBar(
            context: context,
            title: "Log in successful!! please verify email.");
        await verifyEmail(context: context);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(emailVerifyRoute, (route) => false);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        devtools.log("User not found");
        snackBar(context: context, title: "User not found");
      } else if (e.code == "wrong-password") {
        devtools.log("Wrong password");
        snackBar(context: context, title: "wrong-password");
      } else {
        devtools.log("Error : ${e.code}");
        snackBar(context: context, title: "Error : ${e.code}");
      }
      return false;
    }
  }

  // Verify email call
  static Future verifyEmail({required context}) async {
    try {
      await AuthServices.firebase().sendEmailVerification();
      snackBar(context: context, title: "Check your email!!");
    } on FirebaseAuthException catch (e) {
      devtools.log("Error : ${e.code}");
      snackBar(context: context, title: "Error : ${e.code}");
    }
  }

  // logout call
  static Future logout({required context}) async {
    try {
      AuthServices.firebase().logout();
      snackBar(context: context, title: "Log out successful.");
      Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
    } on FirebaseAuthException catch (e) {
      devtools.log("Error : ${e.code}");
      snackBar(context: context, title: "Error : ${e.code}");
    }
  }
}
