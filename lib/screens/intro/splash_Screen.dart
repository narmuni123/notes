import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init(context);
    super.initState();
  }

  init(context) async {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/login/", (route) => false);
    });
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
