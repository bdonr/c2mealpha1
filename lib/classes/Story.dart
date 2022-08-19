import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String id;
  final String title;
  final String description;
  final int likeCount;
  final DocumentReference ref;

  Story(this.id,this.title, this.description,this.likeCount,this.ref);
}