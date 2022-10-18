import 'package:get_it/get_it.dart';
import 'package:test_pokedex/core/network/dio/dio_network_client.dart';
import 'package:test_pokedex/core/network/network_client.dart';
import 'package:test_pokedex/data/repositories/pokemon/pokemon_repository.dart';
import 'package:test_pokedex/features/home/home_cube.dart';

final getIt = GetIt.instance;

class Injector {
  static Future<void> bootstrap() async {
    getIt.registerSingleton<NetworkClient>(
        DioNetworkClient(baseUrl: 'http://104.131.18.84/'));
    getIt.registerLazySingleton(() => PokemonRepository(getIt.get()));
    getIt.registerFactory(() => HomeCube(getIt.get()));
  }

  static T get<T extends Object>() {
    return getIt.get();
  }

  static Future<void> reset() {
    return getIt.reset();
  }
}
