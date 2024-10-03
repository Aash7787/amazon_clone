import 'package:flutter/material.dart';

class DealOfTheDayW extends StatelessWidget {
  const DealOfTheDayW({super.key});

  static const _padding = EdgeInsets.only(left: 10, top: 15);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: _padding,
          alignment: Alignment.topLeft,
          child: const Text(
            'Deal of the day',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Image.network(
          'https://images.unsplash.com/photo-1726682577615-728e4272a60c?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          fit: BoxFit.fitHeight,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: const Text(
            '\$30000',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10),
          child: const Text(
            'A land Rover driving on a foggy road',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ).copyWith(left: 10),
          alignment: Alignment.topLeft,
          child: Text(
            'See all ',
            style: TextStyle(color: Colors.cyan.shade800),
          ),
        )
      ],
    );
  }
}
