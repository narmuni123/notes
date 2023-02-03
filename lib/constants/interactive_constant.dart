import 'package:flutter/material.dart';

snackBar({required context, required String title}) {
  final snackBar = SnackBar(
    content: Text(title),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
