import 'package:flutter/material.dart';
import 'package:test_pokedex/core/di/injector.dart';
import 'package:test_pokedex/data/repositories/pokemon/model/pokemon.dart';
import 'package:test_pokedex/features/detail/detail_page.dart';
import 'package:test_pokedex/features/home/home_page.dart';

Future main() async {
  await Injector.bootstrap();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => const HomePage(),
        '/detail': (context) => DetailPage(
              pokemon: ModalRoute.of(context)?.settings.arguments as Pokemon?,
            ),
      },
    );
  }
}
