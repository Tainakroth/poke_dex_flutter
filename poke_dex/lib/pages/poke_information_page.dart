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
      Response responseDadosPokemon = await dio.get(url);
      var dataPokemon = responseDadosPokemon.data as Map<String, dynamic>;

      // Response response = await dio.get(url);
      // var dadosRequisicaoApi = response.data as Map<String, dynamic>;

      // dataPokemon.addAll(
      //   {'evolutions': dadosRequisicaoApi},
      // );

      return PokemonsDetalhes.fromMap(dataPokemon);
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
            backgroundColor: const Color.fromARGB(255, 162, 189, 189),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 162, 189, 189),
              title: Text(
                _capitalize(pokemonDetalhes!.name),
                style: const TextStyle(
                  color: Color.fromARGB(255, 14, 13, 13),
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 14, 13, 13),
                ),
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
                        color: Color.fromARGB(255, 14, 13, 13),
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
                            color: Color.fromARGB(255, 14, 13, 13),
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
                                color: Color.fromARGB(255, 14, 13, 13),
                              ),
                            ),
                            TextSpan(
                              text: pokemonDetalhes.tipos.join(', '),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 22, 21, 21),
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
                  Column(
                    children: [
                      _buildEvolutionSection(pokemonDetalhes),
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
    double hpPercentage = pokemonsDetalhes.hp / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
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
                color: Color.fromARGB(255, 22, 22, 22),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${pokemonsDetalhes.hp}',
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 20, 20, 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Barra de progresso (LinearProgressIndicator) com largura definida
        Container(
          width: double
              .infinity, // Faz com que a barra ocupe toda a largura disponível
          child: LinearProgressIndicator(
            value: hpPercentage,
            minHeight: 8, // Altura da barra
            color: Colors.green, // Cor da barra
            backgroundColor: Colors.grey[300], // Cor de fundo da barra
          ),
        ),
      ],
    );
  }

  Widget _buildAlturaSection(PokemonsDetalhes pokemonsDetalhes) {
    double alturaPercentage = pokemonsDetalhes.altura / 10;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        Text(
          '${pokemonsDetalhes.altura}m',
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: alturaPercentage,
            minHeight: 8, // Altura da barra
            color: Colors.green, // Cor da barra
            backgroundColor: Colors.grey[300], // Cor de fundo da barra
          ),
        ),
      ],
    );
  }

  Widget _buildPesoSection(PokemonsDetalhes pokemonsDetalhes) {
    double pesoPercentage = pokemonsDetalhes.peso / 200;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        Text(
          '${(pokemonsDetalhes.peso / 10).toStringAsFixed(1)}kg',
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: pesoPercentage,
            minHeight: 8, // Altura da barra
            color: Colors.green, // Cor da barra
            backgroundColor: Colors.grey[300], // Cor de fundo da barra
          ),
        ),
      ],
    );
  }

  Widget _buildAtaqueSection(PokemonsDetalhes pokemonsDetalhes) {
    double ataquePercentage = pokemonsDetalhes.ataque / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.handFist),
          ],
        ),
        const Text(
          'Ataque:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${pokemonsDetalhes.ataque}',
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: ataquePercentage,
            minHeight: 8, // Altura da barra
            color: Colors.green, // Cor da barra
            backgroundColor: Colors.grey[300], // Cor de fundo da barra
          ),
        ),
      ],
    );
  }

  Widget _buildDefesaSection(PokemonsDetalhes pokemonsDetalhes) {
    double defesaPercentage = pokemonsDetalhes.defesa / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        Text(
          '${pokemonsDetalhes.defesa}',
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: defesaPercentage,
            minHeight: 8, // Altura da barra
            color: Colors.green, // Cor da barra
            backgroundColor: Colors.grey[300], // Cor de fundo da barra
          ),
        ),
      ],
    );
  }

  Widget _buildAtaqueEspecialSection(PokemonsDetalhes pokemonsDetalhes) {
    double ataqueEspecialPercentage = pokemonsDetalhes.ataqueespecial / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        Text(
          '${pokemonsDetalhes.ataqueespecial}',
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        Container(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: ataqueEspecialPercentage,
            minHeight: 8, // Altura da barra
            color: Colors.green, // Cor da barra
            backgroundColor: Colors.grey[300], // Cor de fundo da barra
          ),
        ),
      ],
    );
  }

  Widget _buildDefesaEspecialSection(PokemonsDetalhes pokemonsDetalhes) {
    double defesaEspecialPercentage = pokemonsDetalhes.defesaespecial / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
          'DefesaEspecial:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${pokemonsDetalhes.defesaespecial}',
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        Container(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: defesaEspecialPercentage,
            minHeight: 8, // Altura da barra
            color: Colors.green, // Cor da barra
            backgroundColor: Colors.grey[300], // Cor de fundo da barra
          ),
        ),
      ],
    );
  }

  Widget _buildVelocidadeSection(PokemonsDetalhes pokemonDetalhes) {
    double velocidadePercentage = pokemonDetalhes.velocidade / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        Text(
          '${pokemonDetalhes.velocidade}',
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 14, 13, 13),
          ),
        ),
        Container(
          width: double.infinity,
          child: LinearProgressIndicator(
            value: velocidadePercentage,
            minHeight: 8, // Altura da barra
            color: Colors.green, // Cor da barra
            backgroundColor: Colors.grey[300], // Cor de fundo da barra
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
              color: Color.fromARGB(255, 14, 13, 13),
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
    return Card(
      color: const Color.fromARGB(255, 79, 110, 108),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Movimentos:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 245, 242, 242),
                ),
              ),
              const SizedBox(height: 8),
              // Iterando sobre os movimentos e criando um widget para cada um
              Wrap(
                spacing: 8.0, // Espaço entre os chips
                runSpacing: 4.0, // Espaço entre as linhas
                children: pokemonDetalhes.movimentos
                    .map((move) => Chip(
                          label: Text(
                            _capitalize(
                                move), // Capitalizando o nome do movimento
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 117, 141, 126),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEvolutionSection(PokemonsDetalhes pokemonDetalhes) {
    if (pokemonDetalhes.evolucao.isEmpty) {
      return SizedBox(); // Caso não tenha evolução, não exibe nada.
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Evoluções:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Exibindo cada evolução
        for (var evo in pokemonDetalhes.evolucao)
          ListTile(
            title: Text(evo.name),
            leading: Image.network(
              evo.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            subtitle: Text(evo.gifUrl),
          ),
      ],
    );
  }

  Widget _buildHabilidadeCard(String ability) {
    return Card(
      color: const Color.fromARGB(255, 79, 110, 108),
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
                color: Color.fromARGB(255, 245, 242, 242),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
