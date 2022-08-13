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
import 'TopViewMenu.dart';

class PublicView extends StatefulWidget {
  const PublicView({Key? key}) : super(key: key);

  @override
  State<PublicView> createState() => _PublicViewState();
}

class _PublicViewState extends State<PublicView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitCubit, Profile?>(builder: (context, visit) {
      return BlocBuilder<LoginCubit, Profile?>(
        builder: (context, login) {
          if (visit != null && login != null) {
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
                          .findProfile(login.id);
                    }, FaIcon(FontAwesomeIcons.house)),
                    MenuButton(() {
                      Navigator.pushNamed(context, '/messages');
                      BlocProvider.of<VisitCubit>(context)
                          .findProfile(login.id);
                    }, FaIcon(FontAwesomeIcons.message)),
                    MenuButton(() {
                      Navigator.pushNamed(context, '/notifications');
                      BlocProvider.of<VisitCubit>(context)
                          .findProfile(login.id);
                    }, FaIcon(FontAwesomeIcons.bell)),
                    MenuButton(() {
                      Navigator.pushNamed(context, '/search');
                      BlocProvider.of<VisitCubit>(context)
                          .findProfile(login.id);
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
                          image: NetworkImage(visit.profilImageurl),
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        TopViewMenu(visit),

                      ],
                    ),
                  ),
                  expandedHeight: 200,
                ),
                SliverToBoxAdapter(
                    child: ShadowBox(
                        Column(children: [
                          Row(
                            children: [
                              Text("Name:"),
                              Padding(padding: EdgeInsets.only(left: 3)),
                              Text(visit.name),
                            ],
                          ),
                          Row(
                            children: [
                              Text("About Me:"),
                              Padding(padding: EdgeInsets.only(left: 3)),
                              Text(visit.about),
                            ],
                          ),
                        ]),
                        Colors.deepPurple.shade50,
                        Colors.deepPurple.shade50,
                        100,
                        100)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: BlocBuilder<SocialsCubit, List<Social>>(
                        builder: (context, list) {
                      return ShadowBox(
                          SocialList(list),
                          Colors.deepPurple.shade50,
                          Colors.deepPurple.shade50,
                          100,
                          100);
                    }),
                  ),
                )
              ],
            ));
          }
          return Container();
        },
      );
    });
  }
}
