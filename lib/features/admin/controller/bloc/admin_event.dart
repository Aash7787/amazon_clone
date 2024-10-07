part of 'admin_bloc.dart';

@immutable
sealed class AdminEvent {}

class SelectProductImagesEvent extends AdminEvent {
  final List<File> images; // Pass selected images to the event

  SelectProductImagesEvent(this.images);
}
