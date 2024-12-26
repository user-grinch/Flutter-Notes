import 'package:flutter/material.dart';

class NoteSummary extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const NoteSummary({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<NoteSummary> createState() => _NoteSummaryState();
}

class _NoteSummaryState extends State<NoteSummary> {
  @override
  Widget build(BuildContext context) {
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
          widget.text,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        onTap: widget.onPressed,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
