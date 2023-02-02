import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/screens/auth/login_screen.dart';
import 'package:mynotes/screens/auth/registration_screen.dart';
import 'package:mynotes/screens/auth/verify_email_screen.dart';
import 'package:mynotes/screens/home/home_screen.dart';
import 'package:mynotes/screens/home/notes_view_screen.dart';
import 'package:mynotes/screens/intro/splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyNotes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: splashRoute,
      routes: {
        splashRoute: (context) => const SplashScreen(),
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegistrationScreen(),
        homeRoute: (context) => const HomeScreen(),
        emailVerifyRoute: (context) => const VerifyEmailScreen(),
        notesViewRoute: (context) => const NotesViewScreen(),
     },
    );
  }
}

