import 'dart:convert';

class PokemonInfoResponse {

  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;


  PokemonInfoResponse(this.id, this.name, this.imageUrl, this.types,
      this.height, this.weight);

  factory PokemonInfoResponse.fromJson(Map<String,dynamic> json){
    
    final types = (json['types'] as List).map((e) => e['type']['name'] as String).toList();
    return PokemonInfoResponse(json['id'], json['name'], json['sprites']['front_default'], types, json['height'], json['weight']);
  }
}