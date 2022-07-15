import 'package:equatable/equatable.dart';

import '../bloc/PokemonDetailsCubit.dart';

abstract class PageEvents extends Equatable{

  @override
  List<Object?> get props =>[];

}

class StartPage extends PageEvents{

}

class DetailPage extends PageEvents{
  DetailPage(){
  }
  List<Object?> get props =>[];
}

class ViewPokemonListPage extends PageEvents{

}


