
import 'package:poke_dex/models/pokemon_result.dart';

class PokemonResponse {
  final int count;
  final String next;
  final String previous;
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
