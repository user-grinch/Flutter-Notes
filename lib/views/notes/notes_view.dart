import 'package:flutter/material.dart';
import 'package:flutter1/constants/routes.dart';
import 'package:flutter1/services/auth/auth_service.dart';
import 'package:flutter1/services/cloud/cloud_note.dart';
import 'package:flutter1/services/cloud/firebase_cloud_storage.dart';
import 'package:flutter1/views/notes/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Notes", style: TextStyle(fontSize: 32)),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings_rounded),
            onPressed: () async {
              Navigator.of(context).pushNamed(settingsRoute);
            },
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: StreamBuilder(
            stream: _notesService.allNotes(ownerUserId: userId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final allNotes = snapshot.data as Iterable<CloudNote>;
                    return NotesListView(notes: allNotes);
                  } else {
                    return LinearProgressIndicator();
                  }
                default:
                  return const LinearProgressIndicator();
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(createUpdateNoteRoute);
        },
        elevation: 1,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
