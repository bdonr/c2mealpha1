import 'dart:async';

import 'package:c2mealpha1/bloc/loggedin/LoggedInPosition.dart';
import 'package:c2mealpha1/bloc/loggedin/SearchBloc.dart';
import 'package:c2mealpha1/bloc/loggedin/SocialSearchCubit.dart';
import 'package:c2mealpha1/config/SocialConfig.dart';
import 'package:c2mealpha1/events/SearchEvent.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/states/SearchState.dart';
import 'package:c2mealpha1/states/SocialSearchState.dart';
import 'package:c2mealpha1/widgets/ShadowBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import '../classes/Profile.dart';
import '../classes/Social.dart';
import '../classes/SocialMedia.dart';
import '../events/SocialSearchEvent.dart';
import '../widgets/UserListView.dart';

class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var _value = 20.0;
  var _gender = 1.0;
  var _single = 1.0;

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
            500,
            double.infinity),
      )),
      SliverToBoxAdapter(
        child: Material(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Meters around me"),
                  BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                    if (state is SliderMoveState) {
                      _value = state.range;
                    }
                    return Slider(
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: labelRange(),
                      value: _value,
                      onChanged: (value) {
                        print(value);
                        BlocProvider.of<SearchBloc>(context)
                            .add(SliderMoveEvent(value));
                      },
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Which gender?"),
                  BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                    if (state is SliderMoveState2) {
                      _gender = state.gender;
                    }
                    return Slider(
                      min: 0,
                      max: 3,
                      divisions: 2,
                      value: _gender,
                      label: labelGender(),
                      onChanged: (value) {
                        print(value);
                        BlocProvider.of<SearchBloc>(context)
                            .add(SliderMoveEvent2(value));
                      },
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Text("single?"),
                  BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                    print(state);
                    if (state is SliderMoveState3) {
                      _single = state.single;
                    }
                    return Slider(
                      min: 0,
                      max: 3,
                      divisions: 2,
                      value: _single,
                      label: labelSingle(),
                      onChanged: (value) {
                        print(value);
                        BlocProvider.of<SearchBloc>(context)
                            .add(SliderMoveEvent3(value));
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        )),
      ),
      SliverToBoxAdapter(
          child: Container(
              color: Colors.white,
              height: 300,
              child: Center(
                child: BlocBuilder<SocialSearchCubit, List<List<SocialMedia>>>(
                  builder: (context, list) {
                    print("blabla" + list.toString());
                    if (list.length == 0) {
                      return Container();
                    }
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: list[0].length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            child: InkWell(
                              onTap: () {
                                this.setState(() {

                                });
                                if(list[0][index]==SocialMedia.NOTHING){
                                  BlocProvider.of<SocialSearchCubit>(context)
                                      .reset();
                                }
                                else {
                                  BlocProvider.of<SocialSearchCubit>(context)
                                      .swap(list[0][index]);
                                }
                              },
                              child: Container(
                                  color: SocialConfig.configColorByEnum(
                                      list[0][index]),
                                  child: Center(
                                      child: SocialConfig.configTextEnum(
                                          list[0][index]))),
                            ),
                          );
                        });
                  },
                ),
              ))),
      SliverToBoxAdapter(
        child: Container(
            color: Colors.white,
            height: 300,
            child: Center(
              child: BlocBuilder<SocialSearchCubit, List<List<SocialMedia>>>(
                  builder: (context, list2) {
                if (list2.length == 0) {
                  return Container();
                }
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: list2[1].length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:4,
                    mainAxisExtent: 100,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Material(
                      child: Container(
                          color:
                              SocialConfig.configColorByEnum(list2[1][index]),
                          child: Center(
                              child: SocialConfig.configTextEnum(
                                  list2[1][index]))),
                    );
                  },
                );
              }),
            )),
      ),
      SliverToBoxAdapter(
        child: Container(
          color: Colors.white,
          height: 100,
          child: TextButton(
            child: Text("sad"),
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              primary: Colors.blue,
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      )
    ]);
  }

  String labelSingle() {
    if (_single == 0) {
      return "no";
    }
    if (_single > 0 && _single < 2) {
      return "dont care";
    }
    return "yes";
  }

  String labelGender() {
    if (_gender == 0) {
      return "male";
    }
    if (_gender > 0 && _gender < 2) {
      return "dont care";
    }
    return "female";
  }

  String labelRange() {
    return _value.toString() + "meters";
  }
}
