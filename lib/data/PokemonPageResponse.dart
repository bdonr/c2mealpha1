import 'PokemonListing.dart';

class PokemonPageResponse {
  List<PokemonListing> pokemonlisting;
  final bool canLoadNextPage;

  PokemonPageResponse(this.pokemonlisting, this.canLoadNextPage);

  factory PokemonPageResponse.fromJson(Map<String, dynamic> json) {
    final bool canLoadNextPage = json['next'] != null;
    final List<PokemonListing> pokemonlisting = (json['results'] as List)
        .map((listing) => PokemonListing.fromJson(listing))
        .toList();
    return PokemonPageResponse(pokemonlisting, canLoadNextPage);
  }
}
