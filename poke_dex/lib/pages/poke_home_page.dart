import 'package:flutter/material.dart';
import 'package:poke_dex/pages/poke_information_page.dart';
import 'package:poke_dex/models/pokemon_result.dart';

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
    _applyFilter(_currentFiltro); 
  }

  void _applyFilter(String filtro) {
    setState(() {
      _currentFiltro = filtro;
      switch (filtro) {
        case 'A a Z':
          filtroPokemonList = List.from(widget.pokemonList)
            ..sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'Z a A':
          filtroPokemonList = List.from(widget.pokemonList)
            ..sort((a, b) => b.name.compareTo(a.name));
          break;
        case 'Crescente':
          filtroPokemonList = List.from(widget.pokemonList)
            ..sort((a, b) => a.id.compareTo(b.id)); 
          break;
        case 'Decrescente':
          filtroPokemonList = List.from(widget.pokemonList)
            ..sort((a, b) => b.id.compareTo(a.id));
          break;
      }
    });
  }

   void _onPokemonCardPressed(BuildContext context, PokemonResult pokemon) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PokemonInfoPage(pokemon: pokemon),
      ),
    );
  }

  void _filterPokemons(String query) {
    setState(() {
      filtroPokemonList = widget.pokemonList.where((pokemon) {
        final originalIndex = widget.pokemonList.indexOf(pokemon);
        final pokemonNumber = (originalIndex + 1).toString();
        final pokemonName = pokemon.name.toLowerCase();

        return pokemonName.contains(query.toLowerCase()) ||
            pokemonNumber.contains(query);
      }).toList();
    });
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.red[800],
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
                  value: 'A a Z',
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'A a Z',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Z a A',
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Z a A',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Crescente',
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
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
            color: Colors.grey[900],
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
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
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                ),
                style: const TextStyle(color: Colors.black),
                onChanged: _filterPokemons,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtroPokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = filtroPokemonList[index];
                final originalIndex = widget.pokemonList.indexOf(pokemon);
                final pokemonNumber = originalIndex + 1;

                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.grey[800],
                  child: InkWell(
                    onTap: () => _onPokemonCardPressed(context, pokemon),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.network(
                            pokemon.imagemUrl,
                            width: 50,
                            height: 50,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const Icon(Icons.error,
                                  color: Colors.white);
                            },
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '#$pokemonNumber',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            _capitalize(pokemon.name),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

