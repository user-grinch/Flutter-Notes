import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter1/services/auth/auth_service.dart';
import 'package:flutter1/services/crud/notes_service.dart';
import 'package:sqflite/sqflite.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({super.key});

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
  DatabaseNote? _note;
  late final NotesService _notesService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesService = NotesService();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final text = _textController.text;
    await _notesService.updateNote(
      note: _note!,
      text: text,
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<DatabaseNote> createNewNote() async {
    final existingNote = _note;

    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final email = currentUser.email!;

    final owner = await _notesService.getUser(email: email);
    return await _notesService.createNote(owner: owner);
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _notesService.deleteNote(id: note.id);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    if (_textController.text.isNotEmpty && note != null) {
      await _notesService.updateNote(
        note: note,
        text: _textController.text,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
      ),
      body: FutureBuilder(
          future: createNewNote(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _note = snapshot.data as DatabaseNote;
              _setupTextControllerListener();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 150),
                    child: TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Enter Your Note',
                        border: const OutlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 250.0, horizontal: 10.0),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
        elevation: 1,
      ),
    );
  }
}
