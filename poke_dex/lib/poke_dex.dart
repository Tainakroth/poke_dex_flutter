import 'package:flutter/material.dart';
import 'package:poke_dex/pages/splash_page.dart';
//pagina inicial com a logo do aplicativo parte mais estetica
class PokeDexApp extends StatelessWidget {
  const PokeDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 16, 4, 85)!,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
