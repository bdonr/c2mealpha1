import 'package:cloud_firestore/cloud_firestore.dart';

class ObjectImage{
  final String big;
  final String medium;
  final String thumb;
  final DocumentReference ref;
  final DocumentReference parentref;

  ObjectImage(this.big, this.medium, this.thumb, this.ref, this.parentref);
}