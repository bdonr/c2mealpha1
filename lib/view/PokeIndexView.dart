import 'package:c2mealpha1/bloc/NavCubit.dart';
import 'package:c2mealpha1/bloc/PokemonBLoc.dart';
import 'package:c2mealpha1/bloc/PokemonDetailsCubit.dart';
import 'package:c2mealpha1/events/PageEvents.dart';
import 'package:c2mealpha1/states/PokemonState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/PokemonEvent.dart';

class PokeIndexView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PokemonBloc>(context).add(PokemonRequestEvent(0));
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonLoadedSucc) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: ()=>{BlocProvider.of<NavBloc>(context).add(DetailPage()),
                  BlocProvider.of<PokemonDetailsCubit>(context).getPokemonDetails(state.list[index].id)
                  },
                  child: Column(
                    children: [
                      Text(state.list[index].name),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.deepPurple,
                        backgroundImage: NetworkImage(state.list[index].imageUrl),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is PokemonLoadedError) {
            return Center(
              child: Text(state.err.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
