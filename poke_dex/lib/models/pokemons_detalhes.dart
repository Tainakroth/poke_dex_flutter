class PokemonsDetalhes {
  final String name;
  final String imagemUrl;
  final String gifUrl;
  final int id;
  final List<String> tipos;
  final List<String> habilidades;
  final double altura;
  final double peso;
  final int hp;
  final int ataque;
  final int defesa;
  final int ataqueespecial;
  final int defesaespecial;
  final int velocidade;
  final List<String> movimentos;
  final List<Evolution> evolucao;

  PokemonsDetalhes({
    required this.name,
    required this.imagemUrl,
    required this.gifUrl,
    required this.id,
    required this.tipos,
    required this.habilidades,
    required this.altura,
    required this.peso,
    required this.hp,
    required this.ataque,
    required this.defesa,
    required this.ataqueespecial,
    required this.defesaespecial,
    required this.velocidade,
    required this.movimentos,
    required this.evolucao,
  });

  factory PokemonsDetalhes.fromMap(Map<String, dynamic> data) {
    return PokemonsDetalhes(
      name: data['name'] ?? 'Nome não encontrado',
      imagemUrl: data['sprites']?['other']?['official-artwork']
              ?['front_default'] ??
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/0.png', // Valor padrão
      gifUrl: data['sprites']?['versions']?['generation-v']?['black-white']
              ?['animated']?['front_default'] ??
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/0.gif', // Valor padrão
      id: data['id'] ?? 0,
      tipos: List<String>.from(
          data['types']?.map((tipo) => tipo['type']['name']) ?? []),
      habilidades: List<String>.from(data['abilities']
              ?.map((habilidade) => habilidade['ability']['name']) ??
          []),
      altura: (data['height'] ?? 0) / 10.0,
      peso: (data['weight'] ?? 0) / 10.0,
      hp: _getStatValue(data['stats'], 'hp'),
      ataque: _getStatValue(data['stats'], 'attack'),
      defesa: _getStatValue(data['stats'], 'defense'),
      ataqueespecial: _getStatValue(data['stats'], 'special-attack'),
      defesaespecial: _getStatValue(data['stats'], 'special-defense'),
      velocidade: _getStatValue(data['stats'], 'speed'),
      movimentos: List<String>.from(
          data['moves']?.map((move) => move['move']['name']) ?? []),
      evolucao: _getEvolucaoList(data['evolutions'], data['id']),
    );
  }

  static int _getStatValue(List<dynamic> stats, String statName) {
    try {
      var stat = stats?.firstWhere((s) => s['stat']['name'] == statName,
          orElse: () => {'base_stat': 0});
      return stat['base_stat'] ?? 0;
    } catch (e) {
      print("Erro ao pegar valor do stat: $statName");
      return 0;
    }
  }

  static List<Evolution> _getEvolucaoList(dynamic evolutions, int id) {
    if (evolutions == null) return [];

    List<Evolution> evolucao = [];
    var chain = evolutions['chain'];

    while (chain != null) {
      evolucao.add(Evolution.fromMap(
          chain, id)); // Garantir que o id seja passado corretamente
      if (chain['evolves_to'] != null && chain['evolves_to'].isNotEmpty) {
        chain = chain['evolves_to'][0];
      } else {
        chain = null;
      }
    }

    return evolucao;
  }
}

class Evolution {
  final String name;
  final String imageUrl;
  final String shinyImageUrl;
  final String gifUrl;
  final String shinyGifUrl;
  final List<Evolution> nextEvolutions; // Lista de evoluções posteriores
  final String? trigger; // Condição para a evolução (se existir)

  Evolution({
    required this.name,
    required this.imageUrl,
    required this.shinyImageUrl,
    required this.gifUrl,
    required this.shinyGifUrl,
    this.nextEvolutions = const [], // Valor padrão
    this.trigger,
  });

  factory Evolution.fromMap(Map<String, dynamic> data, int pokemonNumber) {
    return Evolution(
      name: data['species']['name'] ?? 'Evolução desconhecida',
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumber.png',
      shinyImageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/$pokemonNumber.png',
      gifUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/$pokemonNumber.gif',
      shinyGifUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/$pokemonNumber.gif',
      nextEvolutions: _getNextEvolutions(data['evolves_to'], pokemonNumber),
      trigger: data['trigger'],
    );
  }

  // Método para obter as evoluções seguintes, se existirem
  static List<Evolution> _getNextEvolutions(
      List<dynamic>? evolucoes, int pokemonNumber) {
    if (evolucoes == null || evolucoes.isEmpty) {
      return [];
    }
    return evolucoes
        .map((evoData) => Evolution.fromMap(evoData, pokemonNumber))
        .toList();
  }
}
