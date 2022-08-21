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
  final TextEditingController controller = new TextEditingController();
  bool showComments = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<StoryCubit, Story?>(builder: (context, visit) {
      return StreamBuilder<List<Comment>>(
          stream: messageRepository.findCommentsOfRef(visit!.ref),
          builder: (context, stream) {
            if (visit != null) {
              return Material(
                  child: CustomScrollView(slivers: [
                TopView(repository.loggedIn!),
                SliverToBoxAdapter(
                    child: ListTile(
                  leading: Container(
                      height: 50,
                      width: 50,
                      child: AvatarView(100, repository.loggedIn!)),
                  title: Text(
                    visit.title,
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Container(
                    child: Text(visit.description.toString()),
                  ),
                  trailing: Container(height:100,width:100,child: LikeCommentRow(visit.ref, repository.loggedIn!)),
                )),
                SliverPadding(padding: EdgeInsets.only(top: 100)),
                SliverToBoxAdapter(child: Divider(),),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: stream.data!.length,
                        (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                          child: FutureBuilder<Profile>(
                              future: stream.data![index].profile,
                              builder: (context, user) {
                                if (user.hasData) {
                                  return ListTile(
                                      leading: Container(
                                          height: 50,
                                          width: 50,
                                          child: AvatarView(100, user.data!)),
                                      subtitle: Column(
                                        children: [
                                           Text(
                                            stream.data![index].text,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          LikeCommentRow(
                                              stream.data![index].ref,
                                              repository.loggedIn!),
                                        ],
                                      ));
                                }
                                return Container();
                              })),
                      Divider(thickness: 1,)
                    ],
                  );
                })),
                SliverToBoxAdapter(
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
                )
              ]));
            }
            return Container();
          });
      return Container();
    }));
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
