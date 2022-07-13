

import 'package:c2mealpha1/data/PokemonListing.dart';
import 'package:equatable/equatable.dart';

abstract class PokemonState extends Equatable{

}

class PokemonInitState extends PokemonState{
  @override
  List<Object?> get props => [];
}

class PokemonLoadingState extends PokemonState{
  List<Object?> get props => [];
}

class PokemonLoadedSucc extends PokemonState{
  final List<PokemonListing> list;
  final bool canLoadNextPage;


  PokemonLoadedSucc(this.list, this.canLoadNextPage);
  List<Object?> get props => [this.list,this.canLoadNextPage];
}

class PokemonLoadedError extends PokemonState{
  final Object err;


  PokemonLoadedError(this.err);
  List<Object?> get props => [this.err];
}