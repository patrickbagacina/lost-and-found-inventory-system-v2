import 'package:flutter_admin/exceptions/api_exception.dart';

abstract class APINotFoundException extends APIException {
  APINotFoundException(String message) : super('Not Found');

  @override
  String get className => (APINotFoundException).toString();
}
