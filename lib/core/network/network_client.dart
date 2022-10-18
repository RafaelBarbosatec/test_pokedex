import 'package:test_pokedex/core/network/network_response.dart';

abstract class NetworkClient {
  Future<NetworkResponse<T>> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
  });
}
