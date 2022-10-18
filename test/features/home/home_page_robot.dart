import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_pokedex/core/network/network_error.dart';
import 'package:test_pokedex/core/network/network_response.dart';
import 'package:test_pokedex/data/repositories/pokemon/model/pokemon.dart';
import 'package:test_pokedex/data/repositories/pokemon/pokemon_repository.dart';
import 'package:test_pokedex/features/home/home_cube.dart';
import 'package:test_pokedex/features/home/home_page.dart';

import '../../util/robot.dart';

class PokemonRepositoryMock extends Mock implements PokemonRepository {}

class HomePageRobot extends Robot {
  late PokemonRepository _repository;
  HomePageRobot(super.tester) {
    _repository = PokemonRepositoryMock();
  }

  Future configure({bool withError = false}) async {
    await _registerDependencies(withError: withError);

    await widgetSetup(const HomePage());
  }

  _registerDependencies({bool withError = false}) async {
    when(() => _repository.getPokemonList(
        limit: any(named: 'limit'), page: any(named: 'page'))).thenAnswer(
      (_) {
        if (withError) {
          return Future.error(NetworkError(response: NetworkResponse()));
        }

        return Future.value([
          Pokemon(name: 'Bulbasaur', type: ['grass'], number: '#001'),
          Pokemon(name: 'Charmander', type: ['fire'], number: '#004'),
          Pokemon(name: 'Squirtle', type: ['water'], number: '#007'),
          Pokemon(name: 'Ekans', type: ['poison'], number: '#023'),
        ]);
      },
    );
    await resetDependencies();
    registerDependency(HomeCube(_repository));
  }

  Future didTapBulbasaur() async {
    await tester.tap(find.text('Bulbasaur').first);
    await tester.pumpAndSettle();
  }

  Future assetSnapshotLoadScreen() => takeSnapshot('HomePage_load_screen');
  Future assetSnapshotLoadScreenError() =>
      takeSnapshot('HomePage_load_screen_error');

  Future assetSnapshotLoadDetailScreen() =>
      takeSnapshot('HomePage_load_detail_screen');
}
