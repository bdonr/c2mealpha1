import 'package:c2mealpha1/view/FollowerView.dart';
import 'package:c2mealpha1/widgets/NearUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ProfilCubit.dart';
import '../classes/Profile.dart';
import '../widgets/FollowUser.dart';
import '../widgets/TopView.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      TopView(),
      BlocBuilder<ProfilCubit, Profile?>(builder: (context, details) {
        print(details!.id);
        if (details != null && details.id == 1) {
          return const FollowUser();
        }
        return SliverToBoxAdapter(child: Container(child: Text("sdad"),),);
      }),

      BlocBuilder<ProfilCubit, Profile?>(builder: (context, details) {
        print(details!.id);
        if (details != null && details.id == 1) {
          return const NearUser();
        }
        return SliverToBoxAdapter(child: Container(child: Text("sdad"),),);
      }),

      /* return
                */
    ]);
  }
}
