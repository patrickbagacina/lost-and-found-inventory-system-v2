import 'package:flutter_admin/exceptions/api_exception.dart';

class APIUnauthorizedException extends APIException {
  APIUnauthorizedException() : super('Unauthorized');

  @override
  String get className => (APIUnauthorizedException).toString();
}
