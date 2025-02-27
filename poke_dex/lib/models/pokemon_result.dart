class PokemonResult {
  final String name;
  final String url;

  PokemonResult({
    required this.name,
    required this.url,
  });

  factory PokemonResult.fromMap(Map<String, dynamic> map) {
    return PokemonResult(
      name: map['name'],
      url: map['url'],
    );
}
}