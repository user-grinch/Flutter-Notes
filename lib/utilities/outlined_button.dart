import 'package:flutter/material.dart';

class OutlinedButtonMD3 extends StatelessWidget {
  final Widget? child;
  final VoidCallback onPressed;

  const OutlinedButtonMD3({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
