import 'package:flutter/material.dart';
import 'package:poke_dex/pages/carregar_page.dart';

class PokeDexApp extends StatelessWidget {
  const PokeDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red[800]!,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const CarregarPage(),
    );
  }
}
