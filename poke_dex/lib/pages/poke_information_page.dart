import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:poke_dex/models/pokemons_detalhes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            backgroundColor: const Color.fromARGB(255, 8, 31, 133),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 5, 13, 131),
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

                  //seções de HP, Altura, Peso, Defesa dentro de um Column
                  Column(
                    children: [
                      _buildHPSection(pokemonDetalhes),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      _buildAlturaSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                      _buildPesoSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Column(
                    children: [
                      _buildAtaqueSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                      _buildDefesaSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Column(
                    children: [
                      _buildAtaqueEspecialSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                      _buildDefesaEspecialSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Column(
                    children: [
                      _buildVelocidadeSection(pokemonDetalhes),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Column(
                    children: [
                      _buildMovimentoSection(pokemonDetalhes),
                      const SizedBox(height: 10),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.favorite,
          color: Colors.red,
          size: 20.0,
        ),
        const SizedBox(width: 8),
        const Text(
          'HP:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.accessibility,
              color: Colors.green,
              size: 20.0,
            ),
          ],
        ),
        SizedBox(width: 8),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.scale,
              color: Colors.orange,
              size: 20.0,
            ),
          ],
        ),
        SizedBox(width: 8),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(FontAwesomeIcons.handFist),
          ],
        ),
        const Text(
          'Ataque:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.shield,
              color: Colors.blue,
              size: 20.0,
            ),
          ],
        ),
        SizedBox(width: 8),
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

  Widget _buildAtaqueEspecialSection(PokemonsDetalhes pokemonsDetalhes) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.flash_on,
              color: Colors.orangeAccent,
              size: 20.0,
            ),
          ],
        ),
        SizedBox(width: 8),
        const Text(
          'AtaqueEspecial:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '${pokemonsDetalhes.ataqueespecial}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDefesaEspecialSection(PokemonsDetalhes pokemonsDetalhes) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DefesaEspecial:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${pokemonsDetalhes.defesaespecial}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildVelocidadeSection(PokemonsDetalhes pokemonDetalhes) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.speed,
              color: Colors.purple,
              size: 20.0,
            ),
          ],
        ),
        SizedBox(width: 8),
        const Text(
          'Velocidade:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '${pokemonDetalhes.velocidade}',
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

  Widget _buildMovimentoSection(PokemonsDetalhes pokemonDetalhes) {
    return Column(
      children: [
        const Text(
          'Movimentos:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '${pokemonDetalhes.movimentos}',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        )
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
