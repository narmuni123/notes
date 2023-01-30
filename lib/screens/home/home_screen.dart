import 'package:capitalize/capitalize.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/provider/auth_provider.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/reusable/dialog_display.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    IsCapitalize isCapitalize = IsCapitalize();
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout =
                      await DialogDisplay.exitApp(context: context);
                  if (shouldLogout) {
                    await authProvider.logout(context: context);
                  }
                  devtools.log(shouldLogout.toString());
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text("Log out"),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
