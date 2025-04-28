import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/ai_product_detail/service/bloc/ai_product_detail_bloc.dart';
import 'package:flutter_amazon_clone/features/ai_product_detail/widget/receiver_message_cart.dart';
import 'package:flutter_amazon_clone/features/ai_product_detail/widget/sender_message_cart.dart';
import 'package:flutter_amazon_clone/features/home/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AiProductDetailScreen extends StatelessWidget {
  const AiProductDetailScreen(
      {super.key, required this.senderMessage, required this.receiverMessage});

  static const route = 'ai_product_detail_screen';

  final ({String promptMessage}) senderMessage;
  final String receiverMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          SenderMessageCart(
            message: 'Prompt send to Ai ${senderMessage.promptMessage}',
            date: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
          ),
          BlocBuilder<AiProductDetailBloc, AiProductDetailState>(
            builder: (context, state) {
              if (state is AiProductDetailLoading) {
                return const Loader();
              } else if (state is AiProductDetailLoaded) {
                return ReceiverMessageCart(
                  date: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
                  message: state.response,
                  color: Colors.green,
                );
              } else if (state is AiProductDetailError) {
                return ReceiverMessageCart(
                  date: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
                  message:
                      'Sorry we are unable to Load the Message\nTry another time',
                  color: Colors.red,
                );
              }
              return const Loader();
            },
          ),
        ],
      ),
    );
  }
}
