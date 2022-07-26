import 'package:c2mealpha1/bloc/FollowsCubit.dart';
import 'package:c2mealpha1/bloc/LoginCubit.dart';
import 'package:c2mealpha1/bloc/MainImageCubit.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/FollowerCubit.dart';
import 'events/PageEvents.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<FirebaseApp> fbApp =
      Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  @override
  Widget build(BuildContext context) {
    final pdc = PokemonDetailsCubit();
    return MaterialApp(
      theme: Theme.of(context)
          .copyWith(primaryColor: Colors.red, accentColor: Colors.redAccent),
      home: FutureBuilder(
          future: fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MultiBlocProvider(providers: [
                BlocProvider(create: (context) => ProfilCubit()),
                BlocProvider(create: (context) => FollowsCubit()..getFollows()),
                BlocProvider(
                    create: (context) =>
                        LoginCubit()..login("50myTvoVDnY1TIkhiFJh")),
                BlocProvider(create: (context) => NearCubit()..get()),
                BlocProvider(
                    create: (context) =>
                        LoggedInImageCubit()..getImage("50myTvoVDnY1TIkhiFJh")),
                BlocProvider(create: (context) => FollowerCubit()..get("50myTvoVDnY1TIkhiFJh")),
              ], child: SafeArea(child: AppNavigator()));
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
