part of 'ai_product_detail_bloc.dart';

@immutable
sealed class AiProductDetailState {}

final class AiProductDetailInitial extends AiProductDetailState {}

final class AiProductDetailLoading extends AiProductDetailState {}

final class AiProductDetailLoaded extends AiProductDetailState {
  final String response;

  AiProductDetailLoaded({required this.response});
}

final class AiProductDetailError extends AiProductDetailState {
  final String error;

  AiProductDetailError(this.error);
}
