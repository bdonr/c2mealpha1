import 'package:c2mealpha1/classes/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String text;
  final Future<Profile> profile;
  final DocumentReference ref;

  Comment(this.text, this.profile, this.ref);
}