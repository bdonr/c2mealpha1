import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PokemonDetailsCubit.dart';

class NavCubit extends Cubit<int?>{

  final PokemonDetailsCubit pokemonDetailsCubit;

  NavCubit(this.pokemonDetailsCubit):super(null);


  void showPokemonDetails(int id){
    pokemonDetailsCubit.getPokemonDetails(id);
    emit(id);
  }

  void popToHome(){
    emit(null);
  }
}