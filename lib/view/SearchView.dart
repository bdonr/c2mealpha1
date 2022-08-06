import 'package:c2mealpha1/bloc/loggedin/FollowerCubit.dart';
import 'package:c2mealpha1/bloc/visit/SocialsCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/NavCubit.dart';
import '../classes/Profile.dart';
import '../events/PageEvents.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: false,
          floating: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () async => {
                    Navigator.of(context).pop(context)
                    // BlocProvider.of<NavBloc>(context)..add(PopPage())
                  }),
          flexibleSpace: Container(child: Text("Search"))),
      SliverToBoxAdapter(child: Container(child:
          BlocBuilder<FollowerCubit, List<Profile?>>(builder: (context, list) {
        return ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
                  child: Text("asda"),
                ));
      })))
    ]);
  }
}
