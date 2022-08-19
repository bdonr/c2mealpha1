import 'package:c2mealpha1/bloc/loggedin/LoginCubit.dart';
import 'package:c2mealpha1/bloc/loggedin/MessageCubit.dart';
import 'package:c2mealpha1/helper/formater.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/NavCubit.dart';
import '../classes/Message.dart';
import '../classes/Profile.dart';
import '../events/PageEvents.dart';
import '../widgets/AvatarView.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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
        child: BlocBuilder<MessageCubit, List<NotificationMessage>>(
            builder: (context, messages) {
          return Material(
            child: ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (messages[index] != null) {
                    if (messages[index].info == "story") {
                      return Card(
                          child: Row(
                        children: [
                          AvatarView(20, messages[index].from),
                          Text(Formater.timeToString(messages[index].time) +
                              " "),
                          Text(messages[index].from.name +
                              " wrote a new story with title " +
                              messages[index].type)
                        ],
                      ));
                    }
                    if (messages[index].info == "follow") {
                      return Card(
                          child: Row(
                        children: [
                          AvatarView(20, messages[index].from),
                          Text(Formater.timeToString(messages[index].time) +
                              " "),
                          Text(messages[index].from.name + " follows you"),
                        ],
                      ));
                    }
                    if (messages[index].info == "socials") {
                      return Card(
                          child: Row(
                            children: [
                              AvatarView(20, messages[index].from),
                              Text(Formater.timeToString(messages[index].time) +
                                  " "),
                              Text(messages[index].from.name + " added "+messages[index].type),
                            ],
                          ));
                    }
                    if (messages[index].info == "message") {
                      return Card(
                          child: Row(
                        children: [
                          AvatarView(20, messages[index].from),
                          Text(Formater.timeToString(messages[index].time) +
                              " "),
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
