import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  Future<bool> registration(
      {required context,
      required String email,
      required String password}) async {
    final value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (kDebugMode) {
      print(value);
    }
    return true;
  }
}
