import 'package:c2mealpha1/bloc/visit/SocialsCubit.dart';
import 'package:c2mealpha1/bloc/visit/VisitCubit.dart';
import 'package:c2mealpha1/config/SocialConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/loggedin/FollowerCubit.dart';
import '../bloc/loggedin/FollowsCubit.dart';
import '../classes/Profile.dart';
import '../classes/Social.dart';
import '../helper/formater.dart';

class TopView extends StatefulWidget {
  const TopView({Key? key}) : super(key: key);

  @override
  State<TopView> createState() => _TopViewState();
}

class _TopViewState extends State<TopView> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: 400,
        backgroundColor: Color(0xFFFFFFFF),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: false,
        floating: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async => {
                  Navigator.of(context).pop(context),
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
        flexibleSpace: Container(
          width: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(27.0)),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white.withOpacity(0.7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.5),
                        spreadRadius: -10,
                        blurRadius: 9,
                        offset: Offset(0, -5), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 200,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 65, bottom: 120),
                        child: FaIcon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0, bottom: 120),
                        child: BlocBuilder<FollowerCubit, List<Profile>>(
                            builder: (context, details) {
                          return Text(
                            Formater.func(details.length),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          );
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 70, bottom: 120),
                        child: BlocBuilder<FollowsCubit, List<Profile?>>(
                            builder: (context, details) {
                          return Text(
                            "Follows${Formater.func(details.length)}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 175, left: 10),
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepPurple)),
                    onPressed: () => {},
                    child: const Text(
                      "follow",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 270),
                child: Text(
                  "My Socials",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),

            ],
          ),
        ));
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton(
    this.callback,
    this.icon, {
    Key? key,
  }) : super(key: key);
  final VoidCallback callback;
  final FaIcon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: callback,
      icon: icon,
      color: Color(0xD2D0D0CE),
      iconSize: 20,
    );
  }
}
