part of 'ai_product_detail_bloc.dart';

@immutable
sealed class AiProductDetailEvent {}

class AiProductSendResponse extends AiProductDetailEvent{
  final String message;

  AiProductSendResponse(this.message);
}
