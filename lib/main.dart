import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/provider/auth_provider.dart';
import 'package:mynotes/screens/auth/login_screen.dart';
import 'package:mynotes/screens/auth/registration_screen.dart';
import 'package:mynotes/screens/auth/verify_email_screen.dart';
import 'package:mynotes/screens/home/home_screen.dart';
import 'package:mynotes/screens/home/notes_view_screen.dart';
import 'package:mynotes/screens/intro/splash_Screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/notesViewScreen/",
        routes: {
          "/splash/": (context) => const SplashScreen(),
          "/login/": (context) => const LoginScreen(),
          "/register/": (context) => const RegistrationScreen(),
          "/homeScreen/": (context) => const HomeScreen(),
          "/emailVerify/": (context) => const VerifyEmailScreen(),
          "/notesViewScreen/": (context) => const NotesViewScreen(),
       },
      ),
    );
  }
}

