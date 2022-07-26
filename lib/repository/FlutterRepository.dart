import 'dart:async';

import 'package:c2mealpha1/widgets/AvatarView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';

import '../classes/MainImage.dart';
import '../classes/Profile.dart';
import '../classes/Social.dart';

class FlutterRepository {
  final databaseReference = FirebaseDatabase.instance;

  static Stream<List<Social>> socials(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("socials")
        .snapshots()
        .map((event) => event.docs
            .map((e) => Social(e.get('name'), e.get('url')))
            .toList());
  }

  static Stream<Profile> getProfile(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((event) => Profile(
            event.id,
            event.get('name'),
            event.get('followerCount'),
            event.get('messageCount'),
            event.get('follows')));
  }

  static Stream<List<Profile>> findUserByLocation(
      LocationData locationData, uid) {
    var geo = new Geoflutterfire();

    GeoFirePoint g = geo.point(
        latitude: locationData.latitude!, longitude: locationData.longitude!);
    //var res = FirebaseFirestore.instance.collection('users').where(FieldPath.documentId, isNotEqualTo: "Pdu9166AKjSz4BxDOaKtmNkRf3h1").orderBy(FieldPath.documentId);
    var res = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('collectionPath');
    return geo
        .collection(collectionRef: res)
        .within(center: g, radius: 10, field: 'position')
        .map((event) => event
            .map((e) => Profile(e.id, e.get('name'), e.get('followerCount'),
                e.get('messageCount'), e.get('follows')))
            .toList());
  }

  static Stream<MainImage> getImage(String id) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("images")
        .where("main", isEqualTo: true)
        .get()
        .then((value) => value.docs.map((e) => MainImage(e.get("url"))).first)
        .asStream();
  }

  static Stream<List<Profile>> findFollower(String id) async* {
    List<Profile> p = [];
    var y = await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("follower")
        .get();

    for(var x in y.docs ){
      x['user'].get().then((o) async*
          {
        p.add(Profile(o.id, o.get("name"), o.get("followerCount"), o.get("messageCount"), o.get("follows")));

      });
    }
    yield p;
  }

}
