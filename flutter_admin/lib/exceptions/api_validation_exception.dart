import 'package:flutter_admin/exceptions/api_exception.dart';

abstract class APIValidationException extends APIException {
  APIValidationException(String message) : super('Validation errors');

  @override
  String get className => (APIValidationException).toString();
}
