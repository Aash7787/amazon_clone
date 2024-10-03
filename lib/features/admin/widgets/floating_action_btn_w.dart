import 'package:flutter/material.dart';

class FloatingActionBtnW extends StatelessWidget {
  const FloatingActionBtnW({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 29, 201, 192),
        onPressed: () {},
        child: const Icon(Icons.add),
      );
  }
}