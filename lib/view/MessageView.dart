
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/NavCubit.dart';
import '../events/PageEvents.dart';


class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [SliverAppBar(
            backgroundColor: Colors.deepPurple,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            centerTitle: false,
            floating: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () async => {
                Navigator.of(context, rootNavigator: true).pop(context)}
            ),
            flexibleSpace: Container(child: Text("Message")))]);
  }
}
