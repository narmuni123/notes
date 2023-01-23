import 'package:flutter/material.dart';

class DialogDisplay {
  static Future<bool> exitApp({required context}) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Sign out",
          ),
          content: const Text(
            "Are you sure you want to sign out?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "Cancel",
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                "Logout",
              ),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
