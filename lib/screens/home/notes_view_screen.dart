import 'package:flutter/material.dart';

class NotesViewScreen extends StatefulWidget {
  const NotesViewScreen({Key? key}) : super(key: key);

  @override
  State<NotesViewScreen> createState() => _NotesViewScreenState();
}

class _NotesViewScreenState extends State<NotesViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
      ),
    );
  }
}
