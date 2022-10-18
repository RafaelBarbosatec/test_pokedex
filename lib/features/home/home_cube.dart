import 'package:cubes/cubes.dart';
import 'package:test_pokedex/data/repositories/pokemon/model/pokemon.dart';
import 'package:test_pokedex/data/repositories/pokemon/pokemon_repository.dart';

class HomeCube extends Cube {
  final pokemonList = <Pokemon>[].obs;
  final showError = false.obs;
  final showLoading = false.obs;
  final PokemonRepository _repository;
  int page = 0;

  HomeCube(this._repository);
  @override
  Future<void> onReady(Object? arguments) async {
    load();
  }

  void load({bool more = false}) {
    if (showLoading.value) {
      return;
    }
    if (more) {
      page++;
    } else {
      page = 0;
    }
    showError.value = false;
    showLoading.value = true;
    _repository
        .getPokemonList(
      page: page,
      limit: 20,
    )
        .then((value) {
      if (more) {
        pokemonList.addAll(value);
      } else {
        pokemonList.update(value);
      }
    }).catchError(
      (e) {
        showError.value = true;
      },
    ).whenComplete(() => showLoading.value = false);
  }
}
