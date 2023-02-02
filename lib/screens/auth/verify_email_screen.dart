import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_services.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Verify Email"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                  "We have sent you a verification email. Please open it to verify your account."),
              SizedBox(
                height: height * 0.01,
              ),
              const Text(
                  "If you haven't received a verification email yet, press the button below."),
              SizedBox(
                height: height * 0.01,
              ),
              ElevatedButton(
                onPressed: () async {
                  AuthServices.firebase().sendEmailVerification();
                },
                child: const Text("Verify email"),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: const Text(
                  "Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
