import 'package:c2mealpha1/bloc/NearCubit.dart';
import 'package:c2mealpha1/bloc/NavCubit.dart';
import 'package:c2mealpha1/bloc/PokemonBLoc.dart';
import 'package:c2mealpha1/bloc/PokemonDetailsCubit.dart';
import 'package:c2mealpha1/bloc/ProfilCubit.dart';
import 'package:c2mealpha1/events/PokemonEvent.dart';
import 'package:c2mealpha1/events/ProfileEvent.dart';
import 'package:c2mealpha1/navigation/AppNavigator.dart';
import 'package:c2mealpha1/states/PageStates.dart';
import 'package:c2mealpha1/view/PokeIndexView.dart';
import 'package:c2mealpha1/view/PokemonDetailsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/FollowCubit.dart';
import 'events/PageEvents.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pdc = PokemonDetailsCubit();
    return MaterialApp(
      theme: Theme.of(context)
          .copyWith(primaryColor: Colors.red, accentColor: Colors.redAccent),
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (context)=> ProfilCubit()..getProfile(1)),
        BlocProvider(create: (context)=> NearCubit()..get()),
        BlocProvider(create: (context)=> FollowCubit()..get()),
      ], child: SafeArea(child: AppNavigator())),
    );
  }
}
