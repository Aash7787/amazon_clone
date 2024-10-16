import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<AdminEvent>((event, emit) {});
    on<SelectProductImagesEvent>(_selectProductImages);
  }

  List<File> images = [];

  // FutureOr<void> _selectProductImages(
  //     AdminEvent event, Emitter<AdminState> emit) {
  //   if (event is SelectProductImagesEvent) {
  //     void selectImage(BuildContext context) async {
  //       var res = await pickImages(context);

  //       images = res;
  //     }

  //     emit(AdminSelectProductImage());
  //   }
  //   return Future.value();
  // }

  // Event handler for selecting product images
  FutureOr<void> _selectProductImages(
      SelectProductImagesEvent event, Emitter<AdminState> emit) {
    images = event.images; // Receive selected images from the event
    emit(AdminSelectProductImage(images)); // Emit the new state
  }
}
