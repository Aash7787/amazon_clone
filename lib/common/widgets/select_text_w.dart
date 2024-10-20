import 'package:flutter/material.dart';

class SelectTextW extends StatelessWidget {
  final FontWeight? fontWeight;

  final double fontSize;

  const SelectTextW(this.text,
      {super.key, this.fontWeight, this.fontSize = 18});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text.toUpperCase(),
      maxLines: 2,
      minLines: 1,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
