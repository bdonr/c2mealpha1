import 'dart:async';

import 'package:c2mealpha1/bloc/loggedin/LoggedInPosition.dart';
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
      SliverToBoxAdapter(
          child: Center(
        child: Container(
          color: Colors.transparent,
          height: 400,
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 100,
                  child: BlocBuilder<LoggedInPosition, List<Profile>>(
                      builder: (context, pos) {
                        print(pos);
                    return UserListView(list: pos);
                  }),
                ),
              ),
            ],
          ),
        ),
      ))
    ]);
  }
}
