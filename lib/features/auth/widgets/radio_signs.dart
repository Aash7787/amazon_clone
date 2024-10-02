import 'package:flutter/material.dart';

class RadioSigns extends StatelessWidget {
  final String radioText;
  final Radio radio;
  final Color ? color;

  const RadioSigns({super.key, required this.radioText, required this.radio, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:color ,
      child: ListTile(
        title: Text(radioText),
        leading: radio,
      ),
    );
  }
}
