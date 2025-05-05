import 'package:flutter/material.dart';

class SelectTextW extends StatelessWidget {
  final FontWeight? fontWeight;

  final String text;
  final int? maxLines;
  final double fontSize;
  final int? minLines;
  const SelectTextW(this.text,
      {super.key,
      this.fontWeight,
      this.fontSize = 18,
      this.maxLines ,
      this.minLines = 1});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text.toUpperCase(),
      maxLines: maxLines,
      minLines: minLines,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
