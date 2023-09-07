class AppError implements Exception {
  final Object? message;
  final StackTrace? stackTrace;

  AppError(this.message, {this.stackTrace});

  @override
  String toString() {
    return message.toString();
  }
}
