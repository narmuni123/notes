import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/interactive_constant.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exception.dart';
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
    } on WeakPasswordAuthException {
      devtools.log("weak password");
      snackBar(context: context, title: "weak-password");
    } on EmailAlreadyInUseAuthException {
      devtools.log("Email is already in use");
      snackBar(context: context, title: "Email is already in use");
    } on InvalidEmailAuthException {
      devtools.log("invalid email");
      snackBar(context: context, title: "invalid-email");
    } on GenericAuthException {
      devtools.log("Error : Authentication");
      snackBar(context: context, title: "Authentication error.");
    }
    return false;
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
    } on UserNotFoundAuthException {
      devtools.log("User not found");
      snackBar(context: context, title: "User not found");
    } on WrongPasswordAuthException {
      devtools.log("Wrong password");
      snackBar(context: context, title: "wrong-password");
    } on GenericAuthException {
      devtools.log("Error : Auth error generic");
      snackBar(context: context, title: "Authentication error.");
    }
    return false;
  }

// Verify email call
  static Future verifyEmail({required context}) async {
    try {
      await AuthServices.firebase().sendEmailVerification();
      snackBar(context: context, title: "Check your email!!");
    } on GenericAuthException {
      devtools.log("Error : Email verify");
      snackBar(context: context, title: "Email verify error.");
    }
  }

// logout call
  static Future logout({required context}) async {
    try {
      AuthServices.firebase().logout();
      snackBar(context: context, title: "Log out successful.");
      Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
    } on GenericAuthException {
      devtools.log("Error : Logout");
      snackBar(context: context, title: "Logout error.");
    }
  }
}
