import 'package:flutter/material.dart';
import 'package:test_pokedex/data/repositories/pokemon/model/pokemon.dart';

class DetailPage extends StatelessWidget {
  final Pokemon? pokemon;
  const DetailPage({super.key, this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pokemon?.getColorByType(),
        elevation: 0,
        title: Text(pokemon?.name ?? ''),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 240,
            padding: const EdgeInsets.only(bottom: 40),
            decoration: BoxDecoration(
              color: pokemon?.getColorByType(),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(child: Image.network(pokemon?.thumbnailImage ?? '')),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(pokemon?.description ?? ''),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildLabelAndValue(
                          'Weight',
                          pokemon?.weight?.toString() ?? '',
                        ),
                        _buildLabelAndValue(
                          'Height',
                          pokemon?.height?.toString() ?? '',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelAndValue(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
        ),
      ],
    );
  }
}
