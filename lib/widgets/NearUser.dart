import 'package:c2mealpha1/widgets/UserListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ProfilCubit.dart';
import '../states/ProfileState.dart';
import '../view/AvatarView.dart';

class NearUser extends StatefulWidget {
  const NearUser({Key? key}) : super(key: key);

  @override
  State<NearUser> createState() => _NearUserState();
}

class _NearUserState extends State<NearUser> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        child: Scaffold(
          body: Row(
            children: [
              Expanded(
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
                          return UserListView(list: state.profile.near);
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
