import 'dart:math';

import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/bloc/loggedin/LoginSocialsCubit.dart';
import 'package:c2mealpha1/bloc/visit/StoryCubit.dart';
import 'package:c2mealpha1/classes/Story.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:c2mealpha1/widgets/TopViewMenu.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/visit/VisitCubit.dart';
import '../classes/Profile.dart';
import '../classes/Social.dart';
import '../helper/formater.dart';
import 'ShadowBox.dart';
import 'SocialList.dart';
import 'TopView.dart';

class PrivatView extends StatefulWidget {
  const PrivatView({Key? key}) : super(key: key);

  @override
  State<PrivatView> createState() => _PrivatViewState();
}

class _PrivatViewState extends State<PrivatView> {
  Object get selected => "60";
  final MessageRepository repository = MessageRepository();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, Profile?>(builder: (context, login) {
      if (login != null) {
        return Material(
            child: CustomScrollView(
          slivers: [
            TopView(login),
            SliverToBoxAdapter(
                child: ShadowBox(
                    Column(children: [
                      Row(
                        children: [
                          const Text("Name:"),
                          const Padding(padding: EdgeInsets.only(left: 3)),
                          Text(login.name),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("About Me:"),
                          const Padding(padding: EdgeInsets.only(left: 3)),
                          Text(login.about),
                        ],
                      ),
                    ]),
                    Colors.deepPurple.shade50,
                    Colors.deepPurple.shade50,
                    100,
                    100)),
            SliverToBoxAdapter(
              child: BlocBuilder<LoginSocialsCubit, List<Social>>(
                  builder: (context, list) {
                return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(1, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 100,
                    child: SocialList(list));
              }),
            ),
            SliverToBoxAdapter(
              child: StreamBuilder<List<Story>>(
                  stream: repository.findStoriesOfUser(),
                  builder: (context, list) {
                    if (list.hasData) {
                      return CarouselSlider.builder(
                        itemCount: list.data!.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          print(list.data);
                          return Stack(
                            children: [
                              Positioned.fill(
                                bottom: 0.0,
                                child: GridTile(
                                  child: Image.network(
                                    login.profilImageurl,
                                    fit: BoxFit.cover,
                                  ),
                                  footer: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)),
                                    height: 40,
                                    child: GridTileBar(
                                      backgroundColor: Colors.black12,
                                      title: Text(
                                        list.data![index].title,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        list.data![index].description,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        BlocProvider.of<StoryCubit>(context).visit(list.data![index].ref);
                                        Navigator.pushNamed(context, "/storyDetail");
                                      },
                                    )),
                              ),
                            ],
                          );
                        },
                        options: CarouselOptions(height: 200.0),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ),
          ],
        ));
      }
      return Container();
    });
  }
}
