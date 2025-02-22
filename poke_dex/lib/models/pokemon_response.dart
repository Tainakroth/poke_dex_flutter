
import 'package:poke_dex/models/pokemon_result.dart';
// response vai pegar as informações como a count o next o previous e os resultados para preeencher no mapa
class PokemonResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonResult> results;

  PokemonResponse({
    required this.count, 
    required this.next, 
    required this.previous, 
    required this.results,
    });

    factory PokemonResponse.fromMap(Map map){
      return PokemonResponse(
        count: map["count"], 
        next: map["next"], 
        previous: map["previous"], 
        results: List<PokemonResult>.from(map["results"].map((i) => PokemonResult.fromMap(i))), 
        
        );

    }
    
    
}
