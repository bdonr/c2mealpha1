import 'dart:async';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../classes/Comment.dart';
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
    user
        ?.collection("stories")
        .add({"user": user, "titel": title, "text": text});
  }

  addComment(DocumentReference ref, String text) async {
    ref.collection("comments")
        .add({"user": repository.loggedIn!.ref, "text": text, "parentref": ref})
        .then((value) =>
        value.update({"ref": value}));
  }

  Stream<Story> findStory(DocumentReference id) {
    return id.snapshots().map((event) =>
        Story(event.id, event.get("titel"),
            event.get("text"), event.get("likeCount"), id));
  }

  Stream<Comment> findComment(DocumentReference id) {
    return id.snapshots().map((e) =>
        Comment(e.get("text"), repository.findProfile(e["user"]), e["ref"],e["parentref"]));
  }


  Stream<List<Comment>> findCommentsOfRef(DocumentReference ref) {
    return ref.collection("comments").snapshots().map((event) {
      return event.docs.map((e) =>
          Comment(e.get("text"), repository.findProfile(e["user"]), e["ref"],e["parentref"]))
          .toList();
    });
  }

  Stream<int> findLikesOfRef(DocumentReference ref) {
    return ref.collection("likes").get().then((value) async {
      return value.docs.length;
    }).asStream();
  }

  like(DocumentReference ref, Profile user) async {
    await ref.collection("likes").add({"user": user.ref});
  }

  unlike(DocumentReference ref, Profile user) async {
    await ref
        .collection("likes")
        .where("user", isEqualTo: user.ref)
        .get()
        .then((value) => value.docs.first.reference.delete());
  }

  Stream<bool> DoIlike(DocumentReference ref, Profile user) {
    return ref
        .collection("likes")
        .where("user", isEqualTo: user.ref)
        .snapshots()
        .map((event) => event.docs.isEmpty);
  }
  Stream<List<Story>>? findStoriesOfLoggedUser() {
    return repository.loggedIn?.ref.collection("stories").snapshots().map((e) =>
        e.docs.map((f) =>
            Story(f.id, f.get("titel"), f.get("text"),
                f.get("likeCount") ?? 0, f.reference))
            .toList());
  }

  Stream<List<Story>> findStoriesOfUser(DocumentReference ref) {
    return ref.collection("stories").snapshots().map((e) =>
        e.docs
            .map((f) =>
            Story(f.id, f.get("titel"), f.get("text"),
                f.get("likeCount") ?? 0, f.reference))
            .toList());
  }
}




/**createMessage(DocumentReference<Object>? user,String text)async{
    DocumentReference<Object>? user = repository.loggedIn?.ref;
    user?.collection("stories").add({"user":user,"titel":title,"text":text});
    }*/
