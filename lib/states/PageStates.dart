import 'package:c2mealpha1/bloc/PokemonDetailsCubit.dart';
import 'package:c2mealpha1/view/PokemonDetailsView.dart';
import 'package:equatable/equatable.dart';

abstract class PageStates extends Equatable{
  @override
  List<Object?> get props =>[];

}

class InitState extends PageStates{

}

class StartPageState extends PageStates{

}

class DetailPageState extends PageStates{

  DetailPageState(){
  }

  @override
  List<Object?> get props =>[];
}

class ViewPokemonListPageState extends PageStates{

}
