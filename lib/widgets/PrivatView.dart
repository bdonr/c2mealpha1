import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/bloc/loggedin/LoginSocialsCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/visit/VisitCubit.dart';
import '../classes/Profile.dart';
import '../classes/Social.dart';
import '../helper/formater.dart';
import 'SocialList.dart';
import 'TopView.dart';

class PrivatView extends StatefulWidget {
  const PrivatView(this.login, this.visit, {Key? key}) : super(key: key);
  final Profile visit;
  final Profile login;

  @override
  State<PrivatView> createState() => _PrivatViewState();
}

class _PrivatViewState extends State<PrivatView> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () async => {
                    Navigator.of(context).pop(context),
                  }),
          actions: [
            MenuButton(() {
              Navigator.pushNamed(context, '/home');
              BlocProvider.of<VisitCubit>(context).findProfile(widget.login.id);
            }, FaIcon(FontAwesomeIcons.house)),
            MenuButton(() {
              Navigator.pushNamed(context, '/messages');
              BlocProvider.of<VisitCubit>(context).findProfile(widget.login.id);
            }, FaIcon(FontAwesomeIcons.message)),
            MenuButton(() {
              Navigator.pushNamed(context, '/notifications');
              BlocProvider.of<VisitCubit>(context).findProfile(widget.login.id);
            }, FaIcon(FontAwesomeIcons.bell)),
            MenuButton(() {
              Navigator.pushNamed(context, '/search');
              BlocProvider.of<VisitCubit>(context).findProfile(widget.login.id);
            }, FaIcon(FontAwesomeIcons.magnifyingGlass)),
          ],
          flexibleSpace: Container(
            height: 300,
            width: 50,
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(27.0)),
            ),
            child: Stack(
              children: [
                Image(
                  image: NetworkImage(widget.login.profilImageurl),
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 200, left: 65, bottom: 120),
                  child: FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.red,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 0, bottom: 120),
                    child: Text(
                      Formater.func(widget.login.followerCount),
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 70, bottom: 120),
                    child: Text(
                      "Follows${Formater.func(widget.login.follows)}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          expandedHeight: 200,
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Text(widget.login!.id),
          ),
        ),
        SliverToBoxAdapter(
          child:
          BlocBuilder<LoginSocialsCubit, List<Social>>(builder: (context, list) {
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(1, 3), // changes position of shadow
                    ),
                  ],
                ),
                height: 100,
                child: SocialList(list));
          }),
        )
      ],
    ));
  }
}
