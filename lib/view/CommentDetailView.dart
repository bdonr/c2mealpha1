import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/visit/StoryCubit.dart';
import '../classes/Story.dart';
import '../widgets/TopView.dart';

class CommentDetailView extends StatefulWidget {
  const CommentDetailView({Key? key}) : super(key: key);

  @override
  State<CommentDetailView> createState() => _CommentDetailViewState();
}

class _CommentDetailViewState extends State<CommentDetailView> {
  FlutterRepository repository =FlutterRepository();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, Story?>(builder: (context, visit) {
      if (visit != null) {
        return Scaffold(
            body: CustomScrollView(slivers: [
              TopView(repository.loggedIn!),
          SliverToBoxAdapter(child: Container(child: Text("TEXT")))
        ]));
      }
      return Container();
    });
  }
}
