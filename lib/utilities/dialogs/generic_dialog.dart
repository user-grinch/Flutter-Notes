import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.entries
            .map(
              (entry) => TextButton(
                onPressed: () => () {
                  if (entry.value != null) {
                    Navigator.of(context).pop(entry.value);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(entry.key),
              ),
            )
            .toList(),
      );
    },
  );
}
