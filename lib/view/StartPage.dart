import 'package:c2mealpha1/bloc/NavCubit.dart';
import 'package:c2mealpha1/bloc/PokemonBLoc.dart';
import 'package:c2mealpha1/bloc/PokemonDetailsCubit.dart';
import 'package:c2mealpha1/states/PokemonState.dart';
import 'package:c2mealpha1/states/ProfileState.dart';
import 'package:c2mealpha1/widgets/AvatarView.dart';
import 'package:c2mealpha1/widgets/FollowUser.dart';
import 'package:c2mealpha1/widgets/NearUser.dart';
import 'package:c2mealpha1/widgets/TopView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return CustomScrollView(slivers: [
      TopView(),
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
      )),
      const FollowUser(),
      const NearUser()

      /* return
                */
    ]);
  }
}
