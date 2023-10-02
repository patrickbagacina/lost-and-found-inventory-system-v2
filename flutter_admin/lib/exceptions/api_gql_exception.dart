import 'package:flutter_admin/exceptions/api_exception.dart';

class APIGraphQLException extends APIException {
  APIGraphQLException(String message) : super(message);

  @override
  String get className => (APIGraphQLException).toString();
}
