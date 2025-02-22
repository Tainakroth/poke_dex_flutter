//criei na models uma classe para puxar atraves da api como parametros o nome a url a imagem e o id os tipos gerações e habilidades dos pokemons
class PokemonResult{
  final String name;
  final String url;
  final String imagemUrl;
  final String gifUrl;
  final int id;
  final List<String>tipos;
  final String geracao;
  final List<String>habilidades;

PokemonResult({
  required this.name,
  required this.url,
  required this.imagemUrl,
  required this.gifUrl,
  required this.id,
  required this.tipos,
  required this.geracao,
  required this.habilidades,
});

   factory PokemonResult.fromMap(Map<String,dynamic> map){
    final pokemonNumero = map['url'].split('/').reversed.elementAt(1);
    final imagemUrl =
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonNumero.png';
    final gifUrl = 
    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/$pokemonNumero.gif';

      return PokemonResult(
      name: map["name"],
      url: map["url"],
      imagemUrl: imagemUrl,
      gifUrl:gifUrl,
      id: int.parse(pokemonNumero),
      tipos:[],
      geracao:'',
      habilidades: [],

      );
    }

}