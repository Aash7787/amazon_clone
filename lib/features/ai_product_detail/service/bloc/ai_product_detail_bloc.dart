import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ai_product_detail_event.dart';
part 'ai_product_detail_state.dart';

class AiProductDetailBloc
    extends Bloc<AiProductDetailEvent, AiProductDetailState> {
  AiProductDetailBloc() : super(AiProductDetailInitial()) {
    on<AiProductDetailEvent>((event, emit) {});
  }
}
