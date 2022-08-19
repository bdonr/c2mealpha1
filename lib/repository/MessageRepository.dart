import 'dart:async';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../classes/Profile.dart';
import '../classes/Story.dart';

class MessageRepository {
  final FlutterRepository repository = FlutterRepository();
  static final MessageRepository _singleton = MessageRepository._internal();

  factory MessageRepository() {
    return _singleton;
  }

  MessageRepository._internal();


  createStory(String title, String text) async {
    DocumentReference<Object>? user = repository.loggedIn?.ref;
    user?.collection("stories").add(
        {"user": user, "titel": title, "text": text});
  }

  addComment( DocumentReference<Object>? ref, String text) async {
    ref!.collection("comments").add({"user":repository.loggedIn!.ref,"text":text,"ref":ref});
  }

  Stream<Story>findStory(DocumentReference id){
    return id.snapshots().map((event) =>Story(event.id, event.get("titel"), event.get("text"),event.get("likeCount"),id));
  }

  like(Story story,Profile user)async{
    print("asdasd");
    print(story.ref.toString());
    await story.ref.collection("likes").add({"user":user.ref});

  }
  unlike(Story story,Profile user)async{
    await story.ref.collection("likes").where("user",isEqualTo: user.ref).get().then((value) => value.docs.first.reference.delete());

  }

  Stream<bool>DoIlike(Story story,Profile user){
    return story.ref.collection("likes").where("user",isEqualTo: user.ref).snapshots().map((event) => event.docs.isEmpty);

  }

  Stream<List<Story>>? findStoriesOfUser() {
    return repository.loggedIn?.ref
        .collection("stories")
        .snapshots()
        .map((e) =>
        e.docs.map((f) => Story(f.id, f.get("titel"), f.get("text"),f.get("likeCount") ?? 0,f.reference))
            .toList());
    }
}

/**createMessage(DocumentReference<Object>? user,String text)async{
    DocumentReference<Object>? user = repository.loggedIn?.ref;
    user?.collection("stories").add({"user":user,"titel":title,"text":text});
    }*/