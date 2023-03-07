import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_actions.dart';
import 'package:mynotes/provider/authentication.dart';
import 'dart:developer' as devtools show log;
import 'package:mynotes/reusable/dialog_display.dart';
import 'package:mynotes/services/auth/auth_services.dart';
import 'package:mynotes/services/crud/notes_services.dart';

class NotesViewScreen extends StatefulWidget {
  const NotesViewScreen({Key? key}) : super(key: key);

  @override
  State<NotesViewScreen> createState() => _NotesViewScreenState();
}

class _NotesViewScreenState extends State<NotesViewScreen> {
  late final NotesService _notesService;

  String get userEmail => AuthServices.firebase().currentUser!.email;

  @override
  void initState() {
    _notesService = NotesService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Notes",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                newNotesRoute,
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout =
                      await DialogDisplay.exitApp(context: context);
                  if (shouldLogout) {
                    await Authentication.logout(context: context);
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
      body: FutureBuilder(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                stream: _notesService.allNotes,
                builder: (context, snap) {
                  switch (snap.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if (snap.hasData) {
                        final allNotes = snap.data as List<DatabaseNotes>;
                        return ListView.builder(
                          itemCount: allNotes.length,
                          itemBuilder: (_, int index) {
                            final note = allNotes[index];
                            return ListTile(
                              title: Text(
                                note.text,
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("No Notes"),
                        );
                      }
                    default:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
