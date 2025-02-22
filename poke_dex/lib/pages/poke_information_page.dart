import 'package:flutter/material.dart';
import 'package:poke_dex/models/pokemon_result.dart';

class PokemonInfoPage extends StatelessWidget{

final PokemonResult pokemon;

const PokemonInfoPage({
  super.key,
  required this.pokemon,
});
  

String _capitalize(String text){
  if(text.isEmpty)return text;
  return text[0].toUpperCase()+text.substring(1);
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

  Widget _buildTiposEGeracaoSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          pokemon.gifUrl,
          width: 150,
          height: 150,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(
              Icons.error,
              color: Colors.white,
              size: 50,
            );
          },
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Tipos: ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: pokemon.tipos.join(', '),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Geração: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: pokemon.geracao,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHabilidadesSection() {
    return Column(
      children: [
        const Center(
          child: Text(
            'Habilidades:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: pokemon.habilidades
              .map((habilidade) => _buildHabilidadeCard(habilidade))
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 7, 61),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 3, 27),
        title: Text(
          _capitalize(pokemon.name),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                _capitalize(pokemon.name),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTiposEGeracaoSection(),
            const SizedBox(height: 20),
            _buildHabilidadesSection(),
          ],
        ),
      ),
    );
  }

}
