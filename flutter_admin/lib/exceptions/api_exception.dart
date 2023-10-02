import 'dart:core' as core;

abstract class Exception implements core.Exception {
  final core.String message;

  Exception(this.message);

  core.String get className;

  @core.override
  core.String toString() {
    return "$className: $message";
  }
}

abstract class APIException extends Exception {
  APIException(core.String message) : super(message);
}
