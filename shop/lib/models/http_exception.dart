class HttpException implements Exception {
  // we are signing a contract with Exception class, that we will implement all functions
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}
