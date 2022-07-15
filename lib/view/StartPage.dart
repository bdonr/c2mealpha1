import 'package:c2mealpha1/bloc/NavCubit.dart';
import 'package:c2mealpha1/bloc/PokemonBLoc.dart';
import 'package:c2mealpha1/bloc/PokemonDetailsCubit.dart';
import 'package:c2mealpha1/states/PokemonState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/PageEvents.dart';
import '../events/PokemonEvent.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("asdasd")),
        body: Container(
          child: Column(
            children: [
              IconButton(
                icon: Icon(Icons.send),
                onPressed: (){
                  BlocProvider.of<NavBloc>(context).add(ViewPokemonListPage());

                },
              ),
              Text("hi"),
            ],
          ),
        ));
  }
}
