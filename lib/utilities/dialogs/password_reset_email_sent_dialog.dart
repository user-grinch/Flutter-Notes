import 'package:flutter/material.dart';
import 'package:flutter1/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetEmailSentDialog(BuildContext context) async {
  return showGenericDialog<void>(
      context: context,
      title: 'Password Reset',
      content:
          'An email has been sent to your email address. Please follow the instructions in the email to reset your password.',
      optionsBuilder: () => {
            'OK': null,
          });
}
