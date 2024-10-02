import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

class BtnW extends StatelessWidget {
  static const double borderRadius = 4;

  final GestureTapCallback? onTap;

  final String btnText;

  final double? fontSize;

  const BtnW({super.key, this.onTap, required this.btnText, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: GlobalVariables.secondaryColor,
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
                  color: GlobalVariables.backgroundColor,
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
