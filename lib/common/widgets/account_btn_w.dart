import 'package:flutter/material.dart';

class AccountBtnW extends StatelessWidget {
  const AccountBtnW({super.key, required this.text, this.onPressed});

  static const _symmetricHorizontal = 10.0;

  static const _radius = 50.0;

  final VoidCallback? onPressed;

  final String text;

  static const opacity = 0.04;

  static const padding = 8.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: _symmetricHorizontal),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: .0),
        borderRadius: BorderRadius.circular(_radius),
        color: Colors.black12.withOpacity(opacity),
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: FittedBox(
            // fit: BoxFit.fill,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
