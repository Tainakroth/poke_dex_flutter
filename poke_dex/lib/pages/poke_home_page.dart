import 'package:flutter/material.dart';
import 'package:poke_dex/models/pokemon_result.dart';
import 'package:poke_dex/models/pokemons_detalhes.dart';
import 'package:poke_dex/pages/poke_information_page.dart';

class PokeHomePage extends StatefulWidget {
  final List<PokemonResult> pokemonList;
  const PokeHomePage({super.key, required this.pokemonList});

  @override
  State<PokeHomePage> createState() => _PokeHomePageState();
}

class _PokeHomePageState extends State<PokeHomePage> {
  List<PokemonResult> filtroPokemonList = [];
  final TextEditingController _searchController = TextEditingController();
  String _currentFiltro = "Crescente";

  @override
  void initState() {
    super.initState();
    filtroPokemonList = List.from(widget.pokemonList);
  }

  void _applyFilter(String filtro) {
    //setState(() {
    //_currentFiltro = filtro;
    //switch (filtro) {
    //case 'Crescente':
    //filtroPokemonList.sort((a, b) => a.id.compareTo(b.id));
    //break;
    //case 'Decrescente':
    //filtroPokemonList.sort((a, b) => b.id.compareTo(a.id));
    //break;
    //}
    //});
  }

  void _filterPokemons(String query) {
    setState(() {
      filtroPokemonList = widget.pokemonList.where((pokemon) {
        final pokemonName = pokemon.name.toLowerCase();
        return pokemonName.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _onPokemonCardPressed(BuildContext context, PokemonResult pokemon) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PokemonInfoPage(url: pokemon.url),
      ),
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 27, 139),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 11, 185),
        title: const Text(
          'Pokemons',
          style: TextStyle(
            color: Color.fromARGB(255, 120, 155, 187),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: _applyFilter,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Crescente',
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Crescente',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Decrescente',
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Decrescente',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ];
            },
            icon: const Icon(Icons.filter_list, color: Colors.white),
            color: const Color.fromARGB(255, 26, 24, 124),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 145, 138, 173),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 30, 29, 122)
                          .withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Digite Seu Pokemon',
                    hintStyle:
                        TextStyle(color: const Color.fromARGB(255, 15, 2, 2)),
                    prefixIcon: const Icon(Icons.search,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 198, 197, 202)),
                  onChanged: _filterPokemons,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: filtroPokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = filtroPokemonList[index];
                  final originalIndex = widget.pokemonList.indexOf(pokemon);
                  final pokemonNumber = originalIndex + 1;
                  final pokemonNumero =
                      pokemon.url.split('/').reversed.elementAt(1);
                  final imagemUrl =
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumero.png';

                  return GestureDetector(
                    onTap: () => _onPokemonCardPressed(context, pokemon),
                    child: Card(
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              imagemUrl,
                              width: 100,
                              height: 100,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Icon(Icons.error,
                                    color: Color.fromARGB(255, 10, 5, 75));
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 9, 79, 136),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            child: Text(
                              '#$pokemonNumber',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 3, 4, 65)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 37, 90, 134),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            child: Text(
                              _capitalize(pokemon.name),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 3, 7, 71),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
