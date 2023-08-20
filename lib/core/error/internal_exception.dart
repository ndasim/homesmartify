import 'failure.dart';

class InternalException extends Failure implements Exception {
  final Object exception;
  final StackTrace? stackTrace;

  const InternalException(this.exception, [this.stackTrace]) : super('Internal error');

  @override
  String toString() => 'InternalException: ${exception.toString()}';
}