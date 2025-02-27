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
  });

  factory PokemonsDetalhes.fromMap(Map<String, dynamic> data) {
    return PokemonsDetalhes(
      name: data['name'] ?? 'Nome não encontrado',
      imagemUrl: data['sprites']?['other']?['official-artwork']
              ?['front_default'] ??
          'Imagem não encontrada',
      gifUrl: data['sprites']?['versions']?['generation-v']?['black-white']
              ?['animated']?['front_default'] ??
          'GIF não encontrado',
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
    );
  }

  static int _getStatValue(List<dynamic> stats, String statName) {
    try {
      var stat = stats.firstWhere(
        (s) => s['stat']['name'] == statName,
        orElse: () => null,
      );
      return stat != null
          ? stat['base_stat']
          : 0; // Retorna 0 se a estatística não for encontrada
    } catch (e) {
      print("Erro ao buscar a estatística: $statName. Erro: $e");
      return 0; // Retorna 0 se houver erro
    }
  }
}
