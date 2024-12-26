import 'package:flutter/material.dart';

class SwitchMD3 extends StatefulWidget {
  final String label;
  final ValueChanged<bool> onChanged;

  const SwitchMD3({
    super.key,
    required this.label,
    required this.onChanged,
  });

  @override
  State<SwitchMD3> createState() => _SwitchMD3State();
}

class _SwitchMD3State extends State<SwitchMD3> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 8),
        Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
            widget.onChanged(value);
          },
          activeColor: colorScheme.primary,
          activeTrackColor: colorScheme.primaryContainer,
          inactiveThumbColor: colorScheme.onSurfaceVariant,
          inactiveTrackColor: colorScheme.surfaceVariant,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}
