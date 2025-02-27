import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:poke_dex/models/pokemons_detalhes.dart';

class PokemonInfoPage extends StatelessWidget {
  final String url;

  const PokemonInfoPage({
    super.key,
    required this.url,
  });

  Future<PokemonsDetalhes> _getDadosPokemon() async {
    var dio = Dio();
    try {
      Response response = await dio.get(url);
      var data = response.data;

      return PokemonsDetalhes.fromMap(data);
    } catch (e) {
      throw Exception('Erro ao buscar dados do Pokémon: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getDadosPokemon(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var pokemonDetalhes = snapshot.data;
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 45, 44, 114),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 43, 32, 85),
              title: Text(
                _capitalize(pokemonDetalhes!.name),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome do Pokémon
                  Center(
                    child: Text(
                      _capitalize(pokemonDetalhes.name),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tipo e imagem do Pokémon dentro de um Row
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        pokemonDetalhes.gifUrl,
                        width: 150,
                        height: 150,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 50,
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Tipos: ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: pokemonDetalhes.tipos.join(', '),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Agora as seções de HP, Altura, Peso, Defesa dentro de um Column
                  Column(
                    children: [
                      _buildHPSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                      _buildAlturaSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                      _buildPesoSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                      _buildAtaqueSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                      _buildDefesaSection(pokemonDetalhes),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Habilidades Section
                  _buildHabilidadesSection(pokemonDetalhes),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  Widget _buildHPSection(PokemonsDetalhes pokemonsDetalhes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HP:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '${pokemonsDetalhes.hp}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildAlturaSection(PokemonsDetalhes pokemonsDetalhes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Altura:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '${pokemonsDetalhes.altura}m',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPesoSection(PokemonsDetalhes pokemonsDetalhes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Peso:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '${(pokemonsDetalhes.peso / 10).toStringAsFixed(1)}kg',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildAtaqueSection(PokemonsDetalhes pokemonsDetalhes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ataque:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '${pokemonsDetalhes.ataque}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDefesaSection(PokemonsDetalhes pokemonsDetalhes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Defesa:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '${pokemonsDetalhes.defesa}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildHabilidadesSection(PokemonsDetalhes pokemonDetalhes) {
    return Column(
      children: [
        const Center(
          child: Text(
            'Habilidades:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Column(
          children: pokemonDetalhes.habilidades
              .map((habilidade) => _buildHabilidadeCard(habilidade))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildHabilidadeCard(String ability) {
    return Card(
      color: const Color.fromARGB(255, 19, 5, 56),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              '- ${_capitalize(ability)}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
