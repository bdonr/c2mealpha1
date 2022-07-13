import 'dart:convert';

import 'package:c2mealpha1/data/PokemonInfoResponse.dart';
import 'package:c2mealpha1/data/PokemonSpeciesInfoResponse.dart';
import 'package:http/http.dart ' as http;
import 'package:http/http.dart';

import '../data/PokemonListing.dart';




class PokemonRepository {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {
    // pokemon?limit=200&offset=400

    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return PokemonPageResponse.fromJson(json);
  }

  Future<PokemonInfoResponse?> getPokemonInfo(int id) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$id');
    try{
      final response = await Client().get(uri);
      final json = jsonDecode(response.body);
      return PokemonInfoResponse.fromJson(json);
    }
    catch(e){
      print(e);
    }

  }

  Future<PokemonSpeciesInfoResponse?> getPokemonSpeciesInfo(int id) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon-species/$id');
    try{
      final response = await Client().get(uri);
      final json = jsonDecode(response.body);
      return PokemonSpeciesInfoResponse.fromJson(json);
    }
    catch(e){
      print(e);
    }

  }




}