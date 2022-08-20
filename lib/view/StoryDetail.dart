import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:c2mealpha1/widgets/AvatarView.dart';
import 'package:c2mealpha1/widgets/LikeCommentRow.dart';
import 'package:c2mealpha1/widgets/TextInputField.dart';
import 'package:c2mealpha1/widgets/TopView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/visit/StoryCubit.dart';
import '../classes/Comment.dart';
import '../classes/Profile.dart';
import '../classes/Story.dart';

class StoryDetail extends StatefulWidget {
  const StoryDetail({Key? key}) : super(key: key);

  @override
  State<StoryDetail> createState() => _StoryDetailState();
}

class _StoryDetailState extends State<StoryDetail> {
  final FlutterRepository repository = FlutterRepository();
  final MessageRepository mrepository = MessageRepository();
  final TextEditingController controller = new TextEditingController();
  bool showComments = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, Story?>(builder: (context, visit) {
      if (visit != null) {
        return Material(
          child: CustomScrollView(
            slivers: [
              TopView(repository.loggedIn!),
              SliverToBoxAdapter(
                  child: Column(
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

                ],
              )),
              SliverToBoxAdapter(child: LikeCommentRow(visit.ref, repository.loggedIn!,visit.likeCount),),
              !showComments
                  ? (SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                height: 100,
                                width: double.infinity,
                                color: Colors.transparent,
                                child: TextInputField(
                                    controller, "write a comment", 160)),
                          ),
                          IconButton(
                              onPressed: () {
                                mrepository.addComment(visit.ref, controller.text);
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.deepPurple,
                              ))
                        ],
                      ),
                    ))
                  : SliverToBoxAdapter(
                      child: Container(),
                    ),
              showComments
                  ? (SliverToBoxAdapter(
                      child: StreamBuilder<List<Comment>>(
                          stream:
                              mrepository.findCommentsOfRef(visit.ref),
                          builder: (context, stream) {
                            if (stream.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                  itemCount: stream.data!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: Colors.orange,
                                      height: 70,
                                      width: 40,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FutureBuilder<Profile>(
                                              future: stream
                                                  .data![index].profile,
                                              builder: (context, user) {
                                                if (user.hasData) {
                                                  return Expanded(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AvatarView(
                                                            20, user.data!),
                                                        Text(user
                                                            .data!.name),
                                                      ],
                                                    ),
                                                  );
                                                }
                                                return Container();
                                              }),
                                          Text(stream.data![index].text)
                                        ],
                                      ),
                                    );
                                  });
                            }
                            return Container();
                          })))
                  : SliverToBoxAdapter(
                      child: Container(),
                    )
            ],
          ),
        );
      }
      return Container();
    });
  }
}
