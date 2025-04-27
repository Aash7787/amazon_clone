import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/ai_product_detail/widget/receiver_message_cart.dart';
import 'package:flutter_amazon_clone/features/ai_product_detail/widget/sender_message_cart.dart';
import 'package:intl/intl.dart';

class AiProductDetailScreen extends StatelessWidget {
  const AiProductDetailScreen(
      {super.key, required this.senderMessage, required this.receiverMessage});

  static const route = 'ai_product_detail_screen';

  final String senderMessage;
  final String receiverMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SenderMessageCart(
            message: senderMessage,
            date: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
          ),
          ReceiverMessageCart(
            date: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
            message: receiverMessage,
          )
        ],
      ),
    );
  }
}
