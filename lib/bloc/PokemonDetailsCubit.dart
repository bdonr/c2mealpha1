import 'package:c2mealpha1/data/PokemonDetail.dart';
import 'package:c2mealpha1/data/PokemonInfoResponse.dart';
import 'package:c2mealpha1/data/PokemonSpeciesInfoResponse.dart';
import 'package:c2mealpha1/repository/PokemonRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetails?>{
  PokemonDetailsCubit():super(null);

  PokemonRepository _rep = PokemonRepository();

  void clearPokemonDetails() => emit(null);

  void getPokemonDetails(int id) async{
    final responses = await Future.wait([
      _rep.getPokemonInfo(id),_rep.getPokemonSpeciesInfo(id)]);
    if(responses[0]!=null && responses[1] != null) {
      final pokeinfo = responses[0] as PokemonInfoResponse;
      final species = responses[1] as PokemonSpeciesInfoResponse;
      emit(PokemonDetails(
          pokeinfo.id,
          pokeinfo.name,
          pokeinfo.imageUrl,
          pokeinfo.types,
          pokeinfo.height,
          pokeinfo.weight,
          species.description));
    }
    return null;

  }
}