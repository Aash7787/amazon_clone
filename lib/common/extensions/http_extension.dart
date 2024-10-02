import 'package:http/http.dart';

extension StatusCode on Response {
  bool get isOk => statusCode == 200;
  bool get isBadRequest => statusCode == 400;
  bool get isNotFound => statusCode == 404;
  bool get isServerError => statusCode >= 500;
}
