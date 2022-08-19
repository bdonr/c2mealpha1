import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:c2mealpha1/widgets/TopView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/visit/StoryCubit.dart';
import '../classes/Story.dart';

class StoryDetail extends StatefulWidget {
  const StoryDetail({Key? key}) : super(key: key);

  @override
  State<StoryDetail> createState() => _StoryDetailState();
}

class _StoryDetailState extends State<StoryDetail> {
  final FlutterRepository repository = FlutterRepository();
  final MessageRepository mrepository = MessageRepository();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          TopView(repository.loggedIn!),
          SliverToBoxAdapter(
            child: BlocBuilder<StoryCubit, Story?>(builder: (context, visit) {
              if (visit != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        height: 100,
                        width: double.infinity,
                        child: Text(
                          visit.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        height: 150,
                        width: double.infinity,
                        child: Text(
                          visit.description,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                    Row(
                      children: [
                        StreamBuilder<bool>(
                            stream: mrepository.DoIlike(
                                visit, repository.loggedIn!),
                            builder: (context, doIFollow) {
                              if (doIFollow.hasData) {
                                if (!doIFollow.data!) {
                                  return IconButton(
                                      onPressed: () {

                                        mrepository.unlike(
                                            visit, repository.loggedIn!);
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        color: Colors.deepPurple,
                                      ));
                                }
                                return IconButton(
                                    onPressed: () {
                                      setState((){});
                                      mrepository.like(
                                          visit, repository.loggedIn!);
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.deepPurple,
                                    ));
                              }
                              return Container();
                            }),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(visit.likeCount.toString()),
                        Padding(padding: EdgeInsets.only(left: 50)),
                        Container(
                          child: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.message,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
              return CircularProgressIndicator();
            }),
          )
        ],
      ),
    );
  }
}
