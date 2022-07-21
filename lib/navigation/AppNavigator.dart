import 'package:c2mealpha1/bloc/NavCubit.dart';
import 'package:c2mealpha1/bloc/PokemonBLoc.dart';
import 'package:c2mealpha1/data/PokemonListing.dart';
import 'package:c2mealpha1/events/PokemonEvent.dart';
import 'package:c2mealpha1/states/PokemonState.dart';
import 'package:c2mealpha1/view/FollowerView.dart';
import 'package:c2mealpha1/view/NotificationView.dart';
import 'package:c2mealpha1/view/PokeIndexView.dart';
import 'package:c2mealpha1/view/PokemonDetailsView.dart';
import 'package:c2mealpha1/view/SearchView.dart';
import 'package:c2mealpha1/view/StartPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/PokemonDetailsCubit.dart';
import '../states/PageStates.dart';
import '../view/MessageView.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, PageStates?>(builder: (context, state) {
      return Navigator(
          pages: [
            if (state == InitState() || state == StartPageState())
              const MaterialPage(child: StartPage()),
            if (state == ViewPokemonListPageState())
              MaterialPage(child: PokeIndexView()),
            if (state == DetailPageState())
              MaterialPage(child: PokemonDetailsView()),
            if (state == MessagePageState())
              MaterialPage(child: MessageView()),
            if (state == FollowerPageState())
              MaterialPage(child: FollowerView()),
            if (state == NotificationPageState())
              MaterialPage(child: NotificationView()),
            if (state == SearchPageState())
              MaterialPage(child: SearchView()),
          ],


          onPopPage: (route, result) {
            BlocProvider.of<NavBloc>(context).popToHome();
            print(result+" ");
            return route.didPop(result);
          });
    });
  }
}
