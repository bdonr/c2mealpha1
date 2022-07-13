import 'package:c2mealpha1/bloc/NavCubit.dart';
import 'package:c2mealpha1/view/PokeIndexView.dart';
import 'package:c2mealpha1/view/PokemonDetailsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int?>(builder: (context, id) {
      return Navigator(
        pages: [
          MaterialPage(child: PokeIndexView()),
          if(id!=null) MaterialPage(child: PokemonDetailsView())

        ],
        onPopPage: (route,result){
          BlocProvider.of<NavCubit>(context).popToHome();
          return route.didPop(result);
        }
      );
    });
  }
}
