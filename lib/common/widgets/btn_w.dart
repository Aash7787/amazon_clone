import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class BtnW extends StatelessWidget {
  final double borderRadius;

  final GestureTapCallback? onTap;

  final String btnText;

  final double? fontSize;

  final Color btnColor;

  final Color textColor;

  final double vertical, horizontal;

  const BtnW(
      {super.key,
      this.onTap,
      this.borderRadius = 4,
      required this.btnText,
      this.fontSize,
      this.btnColor = GlobalVariables.secondaryColor,
      this.horizontal = 8,
      this.vertical = 8,
      this.textColor = GlobalVariables.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                btnText,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
