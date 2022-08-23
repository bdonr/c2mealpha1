import 'package:c2mealpha1/bloc/visit/CommentCubit.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:c2mealpha1/widgets/LikeCommentRow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/visit/StoryCubit.dart';
import '../classes/Comment.dart';
import '../classes/Profile.dart';
import '../classes/Story.dart';
import '../widgets/TextInputField.dart';
import '../widgets/TopView.dart';
import 'StoryDetail.dart';

class CommentDetailView extends StatefulWidget {
  const CommentDetailView({Key? key}) : super(key: key);

  @override
  State<CommentDetailView> createState() => _CommentDetailViewState();
}

class _CommentDetailViewState extends State<CommentDetailView> {
  FlutterRepository repository = FlutterRepository();
  MessageRepository messageRepository = MessageRepository();
  final scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, Story?>(builder: (context, visit) {
      return BlocBuilder<CommentCubit, Comment?>(builder: (context, comment) {
        return StreamBuilder<List<Comment>>(
            stream: messageRepository.findCommentsOfRef(comment!.ref),
            builder: (context, commentlist) {
              if (commentlist.hasData) {
                if (visit != null) {
                  return Material(
                    child: Scaffold(
                        body: CustomScrollView(slivers: [
                      TopView(repository.loggedIn!),
                      SliverToBoxAdapter(
                          child: Container(
                              child: Column(
                        children: [
                          Text(comment.text),
                          LikeCommentRow(comment.ref),
                        ],
                      ))),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: commentlist.data!.length,
                              (BuildContext context, int index) {
                        return Column(
                          children: [
                            FutureBuilder<Profile>(
                                future: commentlist.data![index].profile,
                                builder: (context, user) {
                                  if (user.hasData) {
                                    return CommentItem(
                                        null,
                                        commentlist.data![index].text,
                                        commentlist.data![index].ref,
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
                                child: WriteCommentInput(comment.ref,controller, "write", 160)),
                          ]),
                        ),
                      ),
                      SliverFillRemaining()
                    ])),
                  );
                }
              }
              return Container();
            });
      });
    });
  }
}
