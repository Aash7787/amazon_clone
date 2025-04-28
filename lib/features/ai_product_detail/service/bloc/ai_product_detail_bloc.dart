import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'ai_product_detail_event.dart';
part 'ai_product_detail_state.dart';

class AiProductDetailBloc
    extends Bloc<AiProductDetailEvent, AiProductDetailState> {
  AiProductDetailBloc() : super(AiProductDetailInitial()) {
    on<AiProductSendResponse>(_onSendApiMessage);
  }
  Future<void> _onSendApiMessage(
      AiProductSendResponse event, Emitter<AiProductDetailState> emit) async {
    emit(AiProductDetailLoading());
    try {
      final response = await post(Uri.parse(openAiUrl),
          headers: {
            "Authorization": 'Bearer $apiKey',
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "model": "deepseek/deepseek-r1:free",
            "messages": [
              {
                "role": 'user',
                "content": event.message,
              }
            ],
          }));

      // log('The message for sending is ${event.message}');

      final decoded = jsonDecode(response.body);
      final aiAnswer = decoded['choices'][0]['message']['content'] as String ;

      log('The answer json is $aiAnswer');

      emit(AiProductDetailLoaded(response: aiAnswer));
    } catch (e) {
      emit(AiProductDetailError('An error occurred'));
    }
  }
}
