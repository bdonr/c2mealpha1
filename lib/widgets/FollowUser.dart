import 'package:c2mealpha1/widgets/UserListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ProfilCubit.dart';
import '../states/ProfileState.dart';
import '../view/AvatarView.dart';

class FollowUser extends StatefulWidget {
  const FollowUser({Key? key}) : super(key: key);

  @override
  State<FollowUser> createState() => _FollowUserState();
}

class _FollowUserState extends State<FollowUser> {
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
                          return UserListView(list: state.profile.follower);
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
