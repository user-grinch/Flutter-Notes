import 'package:flutter/material.dart';
import 'package:flutter1/constants/routes.dart';
import 'package:flutter1/services/cloud/cloud_note.dart';

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;

  const NotesListView({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: Text(
              note.text,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                createUpdateNoteRoute,
                arguments: note,
              );
            },
            trailing: Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }
}
