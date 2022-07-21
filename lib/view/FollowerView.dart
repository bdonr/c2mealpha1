import 'package:c2mealpha1/navigation/AppNavigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/NavCubit.dart';
import '../events/PageEvents.dart';


class FollowerView extends StatefulWidget {
  const FollowerView({Key? key}) : super(key: key);

  @override
  State<FollowerView> createState() => _FollowerViewState();
}

class _FollowerViewState extends State<FollowerView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [SliverAppBar(
            backgroundColor: Colors.deepPurple,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            centerTitle: false,
            floating: true,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () async => {
                BlocProvider.of<NavBloc>(context)..add(StartPage())
            }
            ),
            flexibleSpace: Container(child: Text("Follower")))]);
  }
}
