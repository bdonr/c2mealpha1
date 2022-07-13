class PokemonSpeciesInfoResponse{

  final String description;

  PokemonSpeciesInfoResponse({required this.description});

  factory PokemonSpeciesInfoResponse.fromJson(Map<String,dynamic> json){
    print(json['flavor_text_entries'][0]['flavor_text']);
    return PokemonSpeciesInfoResponse(description: json['flavor_text_entries'][0]['flavor_text']);
  }


}