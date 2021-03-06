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
import '../view/ProfileView.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const StartPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/messages': (context) => const MessageView(),
        '/notifications':(context)=>const NotificationView(),
        '/home' : (context)=> const ProfileView(),
        '/search': (context)=> const SearchView(),
        '/profileview': (context)=> const ProfileView(),

      },
    );
  }
}
