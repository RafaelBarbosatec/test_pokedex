import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:test_pokedex/data/repositories/pokemon/model/pokemon.dart';
import 'package:test_pokedex/features/home/home_cube.dart';
import 'package:test_pokedex/features/home/widgets/pokemon_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CubeConsumer<HomeCube>(
      builder: (context, cube) {
        return Scaffold(
          appBar: AppBar(title: const Text('Pokedex')),
          body: Stack(
            children: [
              cube.pokemonList.build<List<Pokemon>>((value) {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    if (index > value.length - 2) {
                      cube.load(more: true);
                    }
                    return PokemonWidget(
                      item: value[index],
                      onTap: () => Navigator.of(context).pushNamed(
                        '/detail',
                        arguments: value[index],
                      ),
                    );
                  },
                );
              }),
              cube.showLoading.build<bool>((value) {
                if (value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox.shrink();
              }),
              cube.showError.build<bool>((value) {
                if (value) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          Text(
                            'Não foi possivel carregar conteudo',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        );
      },
    );
  }
}
