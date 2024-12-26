import 'package:flutter/material.dart';
import 'package:flutter1/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) async {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You cannot share an empty note.',
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
