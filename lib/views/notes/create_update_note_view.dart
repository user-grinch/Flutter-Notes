import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter1/services/auth/auth_service.dart';
import 'package:flutter1/utilities/elevated_button.dart';
import 'package:flutter1/utilities/generics/get_argument.dart';
import 'package:flutter1/services/cloud/cloud_note.dart';
import 'package:flutter1/services/cloud/cloud_storage_constants.dart';
import 'package:flutter1/services/cloud/cloud_storage_exceptions.dart';
import 'package:flutter1/services/cloud/firebase_cloud_storage.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    await _notesService.updateNote(
      documentId: note.documentId,
      text: _textController.text,
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();

    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    } else {
      final existingNote = _note;

      if (existingNote != null) {
        return existingNote;
      }
      final currentUser = AuthService.firebase().currentUser!;
      final newNote =
          await _notesService.createNewNote(ownerUserid: currentUser.id);
      _note = newNote;
      return newNote;
    }
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _notesService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    if (_textController.text.isNotEmpty && note != null) {
      await _notesService.updateNote(
        documentId: note.documentId,
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
          future: createOrGetExistingNote(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _setupTextControllerListener();
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: null,
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
                            vertical: 300.0, horizontal: 10.0),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButtonMD3(
                          onPressed: () async {
                            await _notesService.deleteNote(
                                documentId: _note!.documentId);
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 24,
                              ),
                              SizedBox(width: 10),
                              Text('Delete'),
                            ],
                          ),
                        ),
                        ElevatedButtonMD3(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.save_outlined,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 24,
                              ),
                              SizedBox(width: 10),
                              Text('Save'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const LinearProgressIndicator();
            }
          }),
    );
  }
}
