import 'package:flutter/material.dart';

class SelectTextW extends StatelessWidget {
  const SelectTextW(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text.toUpperCase(),
      maxLines: 2,
      minLines: 1,
      style: const TextStyle(
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
