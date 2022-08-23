import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../classes/Comment.dart';
import '../classes/Profile.dart';
import 'AvatarView.dart';

class LikeCommentRow extends StatefulWidget {
  const LikeCommentRow(this.reference,{Key? key})
      : super(key: key);

  final DocumentReference reference;

  @override
  State<LikeCommentRow> createState() => _LikeCommentRowState();
}

class _LikeCommentRowState extends State<LikeCommentRow> {
  final MessageRepository messageRepository = MessageRepository();
  final FlutterRepository repository = FlutterRepository();
  late bool showComments = false;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          StreamBuilder<bool>(
              stream:
                  messageRepository.DoIlike(widget.reference,repository.loggedIn!),
              builder: (context, doIFollow) {
                if (doIFollow.hasData) {
                  if (!doIFollow.data!) {
                    return IconButton(
                        onPressed: () {
                          messageRepository.unlike(
                              widget.reference, repository.loggedIn!);
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.deepPurple,
                        ));
                  }
                  return IconButton(
                      onPressed: () {
                        setState(() {
                          messageRepository.like(
                              widget.reference, repository.loggedIn!);
                        });
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.heart,
                        color: Colors.deepPurple,
                      ));
                }
                return Container();
              }),
          Padding(padding: EdgeInsets.only(left: 10)),

          StreamBuilder(builder: (context,sn){
            if(sn.hasData){
              return Text(sn.data.toString());
            }
            return Text("0");
          }),

          Padding(padding: EdgeInsets.only(left: 50)),
          Container(
              child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.message,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    setState(() {
                      showComments = !showComments;
                    });
                  }))
        ],
      )
    ]);
  }
}
/**

    children: [
    Row(
    children: [
    Expanded(
    child: StreamBuilder<bool>(
    stream: messageRepository.DoIlike(
    widget.reference, widget.loggedIn),
    builder: (context, doIFollow) {
    if (doIFollow.hasData) {
    if (!doIFollow.data!) {
    return IconButton(
    onPressed: () {
    messageRepository.unlike(
    widget.reference,
    widget.loggedIn);
    },
    icon: FaIcon(
    FontAwesomeIcons.solidHeart,
    color: Colors.deepPurple,
    ));
    }
    return IconButton(
    onPressed: () {
    setState(() {});
    messageRepository.like(
    widget.reference, widget.loggedIn);
    },
    icon: FaIcon(
    FontAwesomeIcons.heart,
    color: Colors.deepPurple,
    ));
    }
    return Container();
    }),
    ),
    Padding(padding: EdgeInsets.only(left: 10)),
    Text(widget.count.toString()),
    Padding(padding: EdgeInsets.only(left: 50)),
    Container(
    child: IconButton(
    icon: FaIcon(
    FontAwesomeIcons.message,
    color: Colors.deepPurple,
    ),
    onPressed: () {
    setState(() {
    showComments = !showComments;
    });
    },
    ),
    ),
    ],
    ),
    Expanded(
    child: Row(children: [
    showComments
    ? Expanded(
    child: Column(
    children: [
    StreamBuilder<List<Comment>>(
    stream: messageRepository
    .findCommentsOfRef(widget.reference),
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
    CrossAxisAlignment
    .start,
    children: [
    FutureBuilder<Profile>(
    future: stream
    .data![index]
    .profile,
    builder:
    (context, user) {
    if (user.hasData) {
    return Expanded(
    child: Row(
    crossAxisAlignment:
    CrossAxisAlignment
    .start,
    children: [
    AvatarView(
    20,
    user.data!),
    Text(user
    .data!
    .name),
    ],
    ),
    );
    }
    return Container();
    }),
    Text(stream
    .data![index].text)
    ],
    ),
    );
    });
    }
    return Container();
    })
    ],

 **/
