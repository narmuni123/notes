import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/interactive_constant.dart';
import 'package:mynotes/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  signIn(context) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final email = _email.text;
    final password = _password.text;
    final response = await authProvider.singIn(
        context: context, email: email, password: password);
    if (response == true) {
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/homeScreen/", (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/verifyEmail/", (route) => false);
      }
    } else {
      snackBar(context: context, title: "Try again later");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login",
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(hintText: "Enter your email"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration:
                      const InputDecoration(hintText: "Enter your password"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                ElevatedButton(
                  onPressed: () async {
                    signIn(context);
                  },
                  child: const Center(
                    child: Text(
                      "Login",
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/register/", (route) => false);
                  },
                  child: const Text(
                    "Register",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
