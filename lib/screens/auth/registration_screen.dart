import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_services.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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

  register(context) async {
    final email = _email.text;
    final password = _password.text;
    await AuthServices.firebase().createUser(
      email: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Register",
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
                    register(context);
                  },
                  child: const Center(
                    child: Text(
                      "Register",
                    ),
                  ),
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
      ),
    );
  }
}
