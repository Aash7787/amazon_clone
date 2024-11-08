import 'package:flutter/cupertino.dart';

class ViewOrderTextW extends StatelessWidget {
  const ViewOrderTextW(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
