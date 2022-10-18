import 'package:flutter/material.dart';
import 'package:test_pokedex/data/repositories/pokemon/model/pokemon.dart';

class PokemonWidget extends StatelessWidget {
  final Pokemon item;
  final VoidCallback? onTap;
  const PokemonWidget({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Material(
        elevation: 8,
        shadowColor: item.getColorByType(),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: item.getColorByType(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '#${item.number}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      item.name ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.mainType,
                      style: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )),
                Expanded(child: Image.network(item.thumbnailImage ?? '')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
