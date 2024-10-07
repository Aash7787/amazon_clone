part of 'admin_bloc.dart';

@immutable
sealed class AdminState {
  const AdminState();
}

@immutable
final class AdminInitial extends AdminState {}

class AdminSelectProductImage extends AdminState {
  final List<File> selectedImages;

  const AdminSelectProductImage(this.selectedImages);
}
