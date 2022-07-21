import 'dart:async';

import 'package:c2mealpha1/repository/PersonRepository.dart';
import 'package:c2mealpha1/widgets/UserListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ProfilCubit.dart';
import '../classes/Profile.dart';
import '../states/ProfileState.dart';
import 'AvatarView.dart';

class FollowUser extends StatefulWidget {
  const FollowUser({Key? key}) : super(key: key);

  @override
  State<FollowUser> createState() => _FollowUserState();
}

class _FollowUserState extends State<FollowUser> {
  GasStationsList _gasStations = [];


  /// The subscription to the stream
  StreamSubscription? _gasStationsListSubscription;

  @override
  void initState() {

    if (_gasStationsListSubscription == null) {
      print('init state radar: stream subscribe');

      _gasStationsListSubscription =
          GasStationRadar.shared.streamController.Perstream.listen((gasStations) {
            setState(() {
              _gasStations = gasStations;
            });

          });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        child: Scaffold(
          body: Row(
            children: [
              const Expanded(
                flex: 2,
                child: Text(
                  "near",
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: BlocBuilder<ProfilCubit, ProfileState>(
                      builder: (context, state) {
                    if (state is ProfileLoadedState) {
                      List<Profile?> x = [];
                      return StreamBuilder(
                          stream: PersonRepository.test(0, 20),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Profile>> snapshot) {
                            if(snapshot.hasData){
                              return UserListView(list: snapshot.data!);
                            }
                            return CircularProgressIndicator();
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
