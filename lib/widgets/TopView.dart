import 'package:c2mealpha1/bloc/visit/SocialsCubit.dart';
import 'package:c2mealpha1/bloc/visit/VisitCubit.dart';
import 'package:c2mealpha1/config/SocialConfig.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/loggedin/FollowerCubit.dart';
import '../bloc/loggedin/FollowsCubit.dart';
import '../bloc/loggedin/LoginCubit.dart';
import '../classes/Profile.dart';
import '../classes/Social.dart';
import '../helper/formater.dart';

class TopView extends StatefulWidget {
  const TopView(this.backBehavior,{Key? key}) : super(key: key);
  final VoidCallback? backBehavior;
  @override
  State<TopView> createState() => _TopViewState();
}

class _TopViewState extends State<TopView> {
  final FlutterRepository repository =FlutterRepository();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async => {
            print(widget.backBehavior.toString()),
            widget.backBehavior,
                Navigator.of(context).pop(context),

              }),
      actions: [
        MenuButton(() {
          Navigator.pushNamed(context, '/home');
        }, FaIcon(FontAwesomeIcons.house)),
        MenuButton(() {
          Navigator.pushNamed(context, '/edit');
        }, FaIcon(FontAwesomeIcons.gear)),
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
        height: 300,
        width: 50,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(27.0)),
        ),
        child: Stack(
          children: [
               Image(
                image: NetworkImage(repository.loggedIn!.profilImageurl),
                alignment: Alignment.center,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
            ),
          ],
        ),
      ),
      expandedHeight: 200,
    );
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
