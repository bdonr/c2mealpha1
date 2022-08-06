import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/bloc/loggedin/LoginSocialsCubit.dart';
import 'package:c2mealpha1/bloc/visit/VisitCubit.dart';
import 'package:c2mealpha1/widgets/SocialList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/visit/SocialsCubit.dart';
import '../classes/Profile.dart';
import '../classes/Social.dart';
import '../config/SocialConfig.dart';
import 'ShadowBox.dart';
import 'TopView.dart';

class PublicView extends StatefulWidget {
  const PublicView(this.login, this.visit, {Key? key}) : super(key: key);
  final Profile login;
  final Profile visit;

  @override
  State<PublicView> createState() => _PublicViewState();
}

class _PublicViewState extends State<PublicView> {
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
              BlocProvider.of<VisitCubit>(context)
                  .findProfile(widget.login!.id);
            }, FaIcon(FontAwesomeIcons.house)),
            MenuButton(() {
              Navigator.pushNamed(context, '/messages');
              BlocProvider.of<VisitCubit>(context)
                  .findProfile(widget.login!.id);
            }, FaIcon(FontAwesomeIcons.message)),
            MenuButton(() {
              Navigator.pushNamed(context, '/notifications');
              BlocProvider.of<VisitCubit>(context)
                  .findProfile(widget.login!.id);
            }, FaIcon(FontAwesomeIcons.bell)),
            MenuButton(() {
              Navigator.pushNamed(context, '/search');
              BlocProvider.of<VisitCubit>(context)
                  .findProfile(widget.login!.id);
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
                  image: NetworkImage(widget.visit.profilImageurl),
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          expandedHeight: 200,
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Text(widget.visit.id),
          ),
        ),
        SliverToBoxAdapter(
          child:
              BlocBuilder<SocialsCubit, List<Social>>(builder: (context, list) {
            return
              ShadowBox(SocialList(list),Colors.grey,Colors.white,100,100);
          }),
        )
      ],
    ));
  }
}
