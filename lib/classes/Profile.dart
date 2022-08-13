import 'package:cloud_firestore/cloud_firestore.dart';

import 'Social.dart';
import 'SocialMedia.dart';

class Profile{
  final String name;
  final String id;
  final String about;
  final int followerCount;
  final int messageCount;
  final int follows;
  final String profilImageurl;
  late DocumentReference<Object> ref;

  Profile(this.id,this.name,this.about,this.followerCount, this.messageCount, this.follows,this.profilImageurl){
    ref =FirebaseFirestore.instance
        .collection("users")
        .doc(id);
  }

}