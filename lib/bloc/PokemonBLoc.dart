import 'package:c2mealpha1/events/PokemonEvent.dart';

import 'package:c2mealpha1/states/PokemonState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/PokemonListing.dart';
import '../repository/PokemonRepository.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _repo = PokemonRepository();

  PokemonBloc() : super(PokemonInitState()) {
    on<PokemonRequestEvent>((event, emit) async {
      emit(PokemonLoadingState());
      try {
        final PokemonPageResponse pokemonResponse =
            await _repo.getPokemonPage(event.page);
        emit(PokemonLoadedSucc(
            pokemonResponse.pokemonListings, pokemonResponse.canLoadNextPage));
      } catch (e) {
        emit(PokemonLoadedError(e));
      }
    });
  }
}
