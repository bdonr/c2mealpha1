import 'dart:async';

import 'package:c2mealpha1/bloc/loggedin/LoggedInPosition.dart';
import 'package:c2mealpha1/bloc/loggedin/SearchBloc.dart';
import 'package:c2mealpha1/events/SearchEvent.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/states/SearchState.dart';
import 'package:c2mealpha1/widgets/ShadowBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import '../classes/Profile.dart';
import '../widgets/UserListView.dart';

class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var _value = 20.0;

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
      SliverToBoxAdapter(
          child: Center(
        child: ShadowBox(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: BlocBuilder<LoggedInPosition, List<Profile>>(
                      builder: (context, pos) {
                    return Container(
                        height: 100, child: UserListView(list: pos));
                  }),
                ),
              ],
            ),
            Colors.grey,
            Colors.grey.shade50,
            100,
            double.infinity),
      )),
      SliverToBoxAdapter(
        child: ShadowBox(Material(child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SliderMoveState) {
              _value = state.range;
            }
            return Slider(
              min: 0,
              max: 100,
              divisions: 100,
              value: _value,
              onChanged: (value) {
                BlocProvider.of<SearchBloc>(context)
                    .add(SliderMoveEvent(value));
              },
            );
          },
        )), Colors.grey, Colors.grey.shade50, 100, double.infinity),
      ),
      SliverToBoxAdapter(
        child: ShadowBox(Material(child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            print(state);
            if (state is SliderMoveState) {
              _value = state.range;
              return Text(_value.toString());
            } else if (state is InitState) {
              _value = 15;
              return Text(_value.toString());
            } else {
              print("NÖ");
              return Text(_value.toString());
            }
          },
        )), Colors.grey, Colors.grey.shade50, 100, double.infinity),
      )
    ]);
  }
}
