import 'package:c2mealpha1/events/PageEvents.dart';
import 'package:c2mealpha1/states/PageStates.dart';
import 'package:c2mealpha1/view/PokemonDetailsView.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PokemonDetailsCubit.dart';

class NavBloc extends Bloc<PageEvents,PageStates?>{
  PokemonDetailsCubit pokemonDetailsCubit= PokemonDetailsCubit();

  NavBloc():super(InitState()){
    on<StartPage>((event, emit) => emit(StartPageState()));
    on<MessagePage>((event, emit) => emit(MessagePageState()));
    on<FollowerPage>((event, emit) => emit(FollowerPageState()));
    on<NotificationPage>((event, emit) => emit(NotificationPageState()));
    on<SearchPage>((event, emit) => emit(SearchPageState()));
    on<PopPage>((event, emit) => emit(PopState()));
    on<ViewPokemonListPage>((event,emit) => emit (ViewPokemonListPageState()));
    on<DetailPage>((event,emit) => {
      emit (DetailPageState())
    });

  }
  void showPokemonDetails(int id) async{
    pokemonDetailsCubit.getPokemonDetails(id);
    await Future<void>.delayed(const Duration(seconds: 2));

  }



  void popToHome(){
    emit(InitState());
  }
}