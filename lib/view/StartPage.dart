import 'package:c2mealpha1/bloc/NavCubit.dart';
import 'package:c2mealpha1/bloc/PokemonBLoc.dart';
import 'package:c2mealpha1/bloc/PokemonDetailsCubit.dart';
import 'package:c2mealpha1/states/PokemonState.dart';
import 'package:c2mealpha1/states/ProfileState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ProfilCubit.dart';
import '../events/PageEvents.dart';
import '../events/PokemonEvent.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilCubit, ProfileState>(builder: (context, state) {
      if (state is ProfileLoadedState) {
        return CustomScrollView(slivers: [
          SliverAppBar(
            actions: [
              Icon(Icons.search),
              Icon(Icons.edit),
              Icon(Icons.menu)
            ],
            expandedHeight: 250.0,
            backgroundColor: Colors.deepPurple,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  state.profile.url,
                  fit: BoxFit.fill,
                )),
            title: Text("Welcome to c2me"),
          ),
          SliverToBoxAdapter(
              child: Container(
            height: 100,
            child: Scaffold(
              body: Column(
                children: [
                  const Text("jo"),
                  IconButton(
                      onPressed: () async => {
                            BlocProvider.of<NavBloc>(context)
                                .add(ViewPokemonListPage()),
                            if (BlocProvider.of<PokemonBloc>(context).state
                                is PokemonInitState)
                              {
                                BlocProvider.of<PokemonBloc>(context)
                                    .add(PokemonRequestEvent(0))
                              }
                          },
                      icon: const Icon(Icons.add)),
                ],
              ),
            ),
          ))
        ]);
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
