import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/loggedin/FollowerCubit.dart';
import '../bloc/loggedin/LoginCubit.dart';

import '../bloc/visit/VisitCubit.dart';
import '../classes/Profile.dart';
import '../widgets/TopView.dart';
import '../widgets/UserListView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 400,
          backgroundColor: Color(0xFFFFFFFF),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: false,
          floating: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () async =>
              {
                Navigator.of(context).pop(context),
                BlocProvider.of<VisitCubit>(context)
                    .findProfile("50myTvoVDnY1TIkhiFJh")
              }),
          actions: [
            MenuButton(() {
              Navigator.pushNamed(context, '/home');
            }, FaIcon(FontAwesomeIcons.house)),
            MenuButton(() {
              Navigator.pushNamed(context, '/messages');
            }, FaIcon(FontAwesomeIcons.message)),
            MenuButton(() {
              Navigator.pushNamed(context, '/notifications');
            }, FaIcon(FontAwesomeIcons.bell)),
            MenuButton(() {
              Navigator.pushNamed(context, '/search');
            }, FaIcon(FontAwesomeIcons.magnifyingGlass)),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 100,
            child: Scaffold(
              body: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      height: 100,
                      color: Colors.white,
                      child: BlocBuilder<LoginCubit, Profile?>(
                          builder: (context, details) {
                            if (details != null) {
                              print(details.toString());
                              return Text(details.name);
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Container(
                height: 100,
                child: Scaffold(body: BlocBuilder<FollowerCubit, List<Profile>>(
                    builder: (context, list) {
                      return UserListView(list: list);
                    }))))
      ]),
    );
  }
}


class ProfileImageHeader extends StatelessWidget {
  const ProfileImageHeader(this.imageurl, {
    Key? key,
  }) : super(key: key);
  final imageurl;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 250,
          width: 700,
          child: ClipRRect(
            child: FadeInImage.assetNetwork(
              placeholder: imageurl,
              image: imageurl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ));
  }
}
