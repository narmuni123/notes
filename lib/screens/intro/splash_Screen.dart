import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/screens/auth/verify_email_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  checkUser() async{
    final user = FirebaseAuth.instance.currentUser;
    if(user?.emailVerified ?? false){

    } else{
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const VerifyEmailScreen(),),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Welcome"),
        ),
      ),
    );
  }
}
