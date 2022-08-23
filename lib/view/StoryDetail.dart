import 'package:c2mealpha1/bloc/visit/CommentCubit.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:c2mealpha1/widgets/AvatarView.dart';
import 'package:c2mealpha1/widgets/LikeCommentRow.dart';
import 'package:c2mealpha1/widgets/ShadowBox.dart';
import 'package:c2mealpha1/widgets/TextInputField.dart';
import 'package:c2mealpha1/widgets/TopView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/visit/CommentsCubit.dart';
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
  final MessageRepository messageRepository = MessageRepository();
  final TextEditingController controller = TextEditingController();
  bool showComments = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, Story?>(builder: (context, visit) {
      if (visit != null) {
        return BlocBuilder<CommentsCubit,List<Comment>>(
            builder: (context, comments) {
                return Scaffold(
                  body: CustomScrollView(slivers: [
                    TopView(repository.loggedIn!),
                    SliverToBoxAdapter(
                        child: CommentItem(
                            visit.title, visit.description, visit.ref,
                            repository: repository)),
                    const SliverPadding(padding: EdgeInsets.only(top: 100)),
                    const SliverToBoxAdapter(
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: comments.length,
                            (BuildContext context, int index) {
                      return Column(
                        children: [
                          FutureBuilder<Profile>(
                              future: comments[index].profile,
                              builder: (context, user) {
                                if (user.hasData) {
                                  return CommentItem(
                                      null,
                                      comments[index].text,
                                      comments[index].ref,
                                      repository: repository);
                                }
                                return Container();
                              }),
                          const Divider(
                            thickness: 1,
                          )
                        ],
                      );
                    })),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(children: [
                          Container(
                              width: double.infinity,
                              height: 150,
                              color: Colors.orange,
                              child: TextInputField(controller, "write", 160)),
                        ]),
                      ),
                    ),SliverFillRemaining()
                  ]),
                );

              return Container();
            });
      }
      return Container();
    });
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem(
    this.title,
    this.description,
    this.reference, {
    Key? key,
    required this.repository,
  }) : super(key: key);

  final FlutterRepository repository;
  final String? title;
  final String description;
  final DocumentReference reference;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
          height: 50, width: 50, child: AvatarView(100, repository.loggedIn!)),
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold),
            )
          : Container(),
      subtitle: InkWell(
        onTap: ()=>Navigator.of(context).pushNamed("/commentDetail"),
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 40)),
              Text(
                description,
                style: const TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w400),
              ),
              LikeCommentRow(reference, repository.loggedIn!),
            ],
          ),
        ),
      ),
    );
  }
}

/**
 *
 * if (visit != null) {
    return Material(
    child: CustomScrollView(slivers: [
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
    SliverToBoxAdapter(
    child: LikeCommentRow(visit.ref, repository.loggedIn!),
    ),

    if (stream.hasData) {
    return SliverList(
    delegate: SliverChildBuilderDelegate(
    childCount: stream.data!.length,
    (BuildContext context, int index) {
    return Container(
    child: FutureBuilder<Profile>(
    future: stream.data![index].profile,
    builder: (context, user) {
    if (user.hasData) {
    return
    ListTile(
    leading: Container(
    height: 50,
    width: 50,
    child: AvatarView(20, user.data!)),
    title: Text(
    stream.data![index].text,
    style: TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold),
    ),
    subtitle: LikeCommentRow(
    stream.data![index].ref,
    repository.loggedIn!),
    trailing: Icon(
    Icons.keyboard_arrow_right,
    color: Colors.black87,
    size: 30.0));

    }
    return Container();
    }));
    }),
    );
    }
    return SliverToBoxAdapter(child: Container());
    },
    ),
    !showComments
    ? (SliverToBoxAdapter(
    child: Row(
    children: [
    Expanded(
    child: Container(
    height: 100,
    width: double.infinity,
    color: Colors.black54,
    child: TextInputField(
    controller, "write a comment", 160)),
    ),
    IconButton(
    onPressed: () {
    messageRepository.addComment(
    visit.ref, controller.text);
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
    ]));
    }
    return Container();
    }),
    );
    }
 **/
