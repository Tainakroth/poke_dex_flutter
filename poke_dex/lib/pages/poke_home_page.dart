import 'package:flutter/material.dart';
import 'package:poke_dex/models/pokemon_result.dart';
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
    setState(() {
      _currentFiltro = filtro;
      switch (filtro) {
        case 'Crescente':
          filtroPokemonList.sort((a, b) => a.id.compareTo(b.id));
          break;
        case 'Decrescente':
          filtroPokemonList.sort((a, b) => b.id.compareTo(a.id));
          break;
      }
    });
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
        builder: (context) => PokemonInfoPage(pokemon: pokemon),
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
      backgroundColor: const Color.fromARGB(255, 80, 77, 116),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 68, 107),
        title: const Text(
          'Pokedex',
          style: TextStyle(
            color: Colors.white,
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
            // Campo de pesquisa
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 30, 29, 122).withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar pokémon...',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: const Icon(Icons.search, color: Colors.red),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                  ),
                  style: const TextStyle(color: Color.fromARGB(255, 31, 8, 133)),
                  onChanged: _filterPokemons,
                ),
              ),
            ),
            // GridView
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Uma coluna
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: filtroPokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = filtroPokemonList[index];
                  final originalIndex = widget.pokemonList.indexOf(pokemon);
                  final pokemonNumber = originalIndex + 1;

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
                              pokemon.imagemUrl,
                              width: 100,
                              height: 100,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return const Icon(Icons.error, color: Colors.white);
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                            child: Text(
                              '#$pokemonNumber',
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                            child: Text(
                              _capitalize(pokemon.name),
                              style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
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
