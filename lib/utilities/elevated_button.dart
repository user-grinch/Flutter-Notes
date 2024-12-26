import 'package:flutter/material.dart';

class ElevatedButtonMD3 extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const ElevatedButtonMD3({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<ElevatedButtonMD3> createState() => _ElevatedButtonMD3State();
}

class _ElevatedButtonMD3State extends State<ElevatedButtonMD3> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: widget.onPressed,
      child: Text(widget.text),
    );
  }
}
