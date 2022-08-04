import 'package:c2mealpha1/bloc/LoginCubit.dart';
import 'package:c2mealpha1/bloc/MessageCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/NavCubit.dart';
import '../classes/Message.dart';
import '../classes/Profile.dart';
import '../events/PageEvents.dart';
import '../widgets/AvatarView.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
          backgroundColor: Colors.deepPurple,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: false,
          floating: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () async => {Navigator.of(context).pop(context)}),
          flexibleSpace: Container(child: Text("Message"))),
      SliverToBoxAdapter(
        child: BlocBuilder<MessageCubit, List<Message>>(
            builder: (context, messages) {
          return Material(
            child: ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (messages[index] != null) {
                    if (messages[index].info == "stories") {
                      return Card(
                          child: Row(
                        children: [
                          AvatarView(20, messages[index].from),
                          Text(messages[index].from.name +
                              " wrote a new story with title" +
                              messages[index].info)
                        ],
                      ));
                    }
                    if (messages[index].info == "follow") {
                      return Card(
                          child: Row(
                        children: [
                          AvatarView(20, messages[index].from),
                          Text(messages[index].from.name + " follows you"),
                        ],
                      ));
                    }

                    if (messages[index].info == "message") {
                      return Card(child: Row(
                        children: [
                          AvatarView(20, messages[index].from),
                          Text(messages[index].from.name + " wrote a message"),
                        ],
                      ));
                    }
                  }
                  return CircularProgressIndicator();
                }),
          );
        }),
      )
    ]);
  }
}
