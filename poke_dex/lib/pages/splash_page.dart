import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:poke_dex/models/pokemon_response.dart';
import 'package:poke_dex/models/pokemon_result.dart';
import 'package:poke_dex/pages/poke_home_page.dart';
//a pagina splash vai pegar os pokemons e mostrar na home page 
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<PokemonResult> pokemonList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getPokemons();
  }

  Future<void> _getPokemons() async {
    final dio = Dio();
    final response = 
    await dio.get('https://pokeapi.co/api/v2/pokemon?limit=1034');

    var model = PokemonResponse.fromMap(response.data);
    pokemonList = model.results;
    isLoading = false; 
    if(!context.mounted) return;  
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => PokeHomePage(pokemonList: pokemonList)),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 63, 55, 136),
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
            isLoading == true ?
          const CircularProgressIndicator(
            color: Colors.white,
          ) : SizedBox()
          ],
        ),
      ),
    );
  }
}