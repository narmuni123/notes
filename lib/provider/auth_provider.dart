// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mynotes/constants/interactive_constant.dart';
// import 'package:mynotes/constants/routes.dart';
// import 'dart:developer' as devtools show log;
//
// enum MenuAction { logout }
//
// class AuthProvider extends ChangeNotifier {
//
//   // Registration call
//   Future<bool> registration(
//       {required context,
//       required String email,
//       required String password}) async {
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await verifyEmail(context: context);
//       Navigator.of(context).pushNamed(emailVerifyRoute);
//       snackBar(context: context, title: "User created successfully");
//       notifyListeners();
//       return true;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "weak-password") {
//         devtools.log("weak password");
//         snackBar(context: context, title: "weak-password");
//       } else if (e.code == "email-already-in-use") {
//         devtools.log("Email is already in use");
//         snackBar(context: context, title: "Email is already in use");
//       } else if (e.code == "invalid-email") {
//         devtools.log("invalid email");
//         snackBar(context: context, title: "invalid-email");
//       } else {
//         devtools.log("Error : ${e.code}");
//         snackBar(context: context, title: "Error : ${e.code}");
//       }
//       notifyListeners();
//       return false;
//     }
//   }
//
//   // Sign in call
//   Future<bool> singIn(
//       {required context,
//       required String email,
//       required String password}) async {
//     try {
//       final value = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       devtools.log(value.toString());
//       final user = FirebaseAuth.instance.currentUser;
//       if (user?.emailVerified ?? false) {
//         snackBar(context: context, title: "Log in successful!!");
//         Navigator.of(context)
//             .pushNamedAndRemoveUntil(homeRoute, (route) => false);
//       } else {
//         snackBar(
//             context: context,
//             title: "Log in successful!! please verify email.");
//         await verifyEmail(context: context);
//         Navigator.of(context)
//             .pushNamedAndRemoveUntil(emailVerifyRoute, (route) => false);
//       }
//       notifyListeners();
//       return true;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "user-not-found") {
//         devtools.log("User not found");
//         snackBar(context: context, title: "User not found");
//       } else if (e.code == "wrong-password") {
//         devtools.log("Wrong password");
//         snackBar(context: context, title: "wrong-password");
//       } else {
//         devtools.log("Error : ${e.code}");
//         snackBar(context: context, title: "Error : ${e.code}");
//       }
//       notifyListeners();
//       return false;
//     }
//   }
//
//   // Verify email call
//   Future verifyEmail({required context}) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       await user?.sendEmailVerification();
//       snackBar(context: context, title: "Check your email!!");
//       notifyListeners();
//     } on FirebaseAuthException catch (e) {
//       devtools.log("Error : ${e.code}");
//       snackBar(context: context, title: "Error : ${e.code}");
//       notifyListeners();
//     }
//   }
//
//   // logout call
//   Future logout({required context}) async {
//     try {
//       FirebaseAuth.instance.signOut();
//       snackBar(context: context, title: "Log out successful.");
//       Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
//       notifyListeners();
//     } on FirebaseAuthException catch (e) {
//       devtools.log("Error : ${e.code}");
//       snackBar(context: context, title: "Error : ${e.code}");
//       notifyListeners();
//     }
//   }
// }
