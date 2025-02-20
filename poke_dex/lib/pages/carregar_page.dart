import 'package:flutter/material.dart';
import 'package:poke_dex/models/pokemon_result.dart';
import 'package:poke_dex/pages/poke_home_page.dart';
import 'package:poke_dex/models/pokemon_response.dart';
import 'package:dio/dio.dart';

class CarregarPage extends StatefulWidget {
  const CarregarPage({super.key});

  @override
  State<CarregarPage> createState() => _CarregarPageState();
}

class _CarregarPageState extends State<CarregarPage> {
  List<PokemonResult> pokemonList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getPokemons();
  }

  Future<void> _getPokemons() async {
    try {
      final dio = Dio();
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=1034');
      var model = PokemonResponse.fromMap(response.data);

      setState(() {
        pokemonList = model.results;
        isLoading = false;
      });

      if (!isLoading) {
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => PokeHomePage(pokemonList: pokemonList),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    } catch (e) {
      print('Erro ao carregar Pokémon: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pokédex',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.catching_pokemon,
              size: 100,
              color: Colors.white,
            ),
            if (isLoading) const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator(
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
