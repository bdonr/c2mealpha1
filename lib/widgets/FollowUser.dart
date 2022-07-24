import 'dart:async';

import 'package:c2mealpha1/bloc/FollowerCubit.dart';
import 'package:c2mealpha1/bloc/NearCubit.dart';
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
  /// The subscription to the stream
  StreamSubscription? _gasStationsListSubscription;

  @override
  void initState() {
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
                  "follower",
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: BlocBuilder<FollowerCubit, List<Profile>>(
                      builder: (context, details) {
                    return UserListView(list: details);
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
