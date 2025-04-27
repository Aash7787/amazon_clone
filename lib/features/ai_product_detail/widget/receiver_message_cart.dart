import 'package:flutter/material.dart';

class ReceiverMessageCart extends StatelessWidget {
  final String message;
  final String date;

  const ReceiverMessageCart({
    super.key,
    required this.date,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width - 5, minWidth: 110),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Colors.green,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 7, right: 7, bottom: 30, top: 7),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 17, color: Colors.white60),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      date,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.white60),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.face,
                      size: 20,
                      color: Colors.white60,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
