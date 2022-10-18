import 'package:test_pokedex/core/network/network_response.dart';

class NetworkError implements Exception {
  final NetworkResponse response;
  final dynamic error;

  NetworkError({required this.response, this.error});

  @override
  String toString() {
    return 'NetworkError{ response: $response, error: $error}';
  }
}
