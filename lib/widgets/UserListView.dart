import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ProfilCubit.dart';
import '../classes/Profile.dart';
import '../states/ProfileState.dart';
import '../states/ProfileState.dart';
import 'AvatarView.dart';

class UserListView extends StatefulWidget {
  const UserListView({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List<Profile?> list;

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.list.length,
      itemBuilder: (context, index) => widget!=null ? AvatarView(30, ""):Text("n"),
    );
  }
}
