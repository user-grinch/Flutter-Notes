import 'package:flutter/material.dart';

class OutlinedButtonMD3 extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const OutlinedButtonMD3({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<OutlinedButtonMD3> createState() => _OutlinedButtonMD3State();
}

class _OutlinedButtonMD3State extends State<OutlinedButtonMD3> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: widget.onPressed,
      child: Text(widget.text),
    );
  }
}
