import 'dart:async';

import 'package:c2mealpha1/classes/Message.dart';
import 'package:c2mealpha1/repository/CollectionEnum.dart';
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
import 'Flutter.dart';

class FlutterRepository {
  final databaseReference = FirebaseDatabase.instance;
  static List<Profile> follower = [];

  static Stream<List<Social>> socials(uid) {
    return FlutterRepo.getReferenceAndSubCollectionAsStream(
            uid, CollectionEnum.users, CollectionEnum.socials)
        .map((event) => event.docs
            .map((e) => Social(e.get('name'), e.get('url')))
            .toList());
  }

  static Stream<Profile> getProfile(uid) {
    return FlutterRepo.getReferenceOFCollectionAsStream(
            uid, CollectionEnum.users)
        .asyncMap((event) async => Profile(
            event.id,
            event.get('name'),
            event.get('followerCount'),
            event.get('messageCount'),
            event.get('follows'),
            "sadas"));
  }

  static Stream<List<Profile>> findUserByLocation(
      LocationData locationData, uid) {
    var geo = new Geoflutterfire();

    GeoFirePoint g = geo.point(
        latitude: locationData.latitude!, longitude: locationData.longitude!);
    //var res = FirebaseFirestore.instance.collection('users').where(FieldPath.documentId, isNotEqualTo: "Pdu9166AKjSz4BxDOaKtmNkRf3h1").orderBy(FieldPath.documentId);

    return geo
        .collection(
            collectionRef:
                FlutterRepo.getReferenceOFCollection(CollectionEnum.users))
        .within(center: g, radius: 10, field: 'position')
        .map((event) => event
            .map((e) => Profile(e.id, e.get('name'), e.get('followerCount'),
                e.get('messageCount'), e.get('follows'), "sadas"))
            .toList());
  }

  static Stream<MainImage> getImage(String id) {
    return FlutterRepo.getReferenceAndSubCollection(
            id, CollectionEnum.users, CollectionEnum.images)
        .where("main", isEqualTo: true)
        .get()
        .then((value) => value.docs.map((e) => MainImage(e.get("url"))).first)
        .asStream();
  }

  static Stream<List<Profile>> findFollower(String id) =>
      FlutterRepo.getReferenceAndSubCollectionAsStream(
              id, CollectionEnum.users, CollectionEnum.follower)
          .asyncMap<List<Profile>>(
            (profileList) => Future.wait(_mapList(profileList)),
          )
          .asBroadcastStream();

  static Stream<List<Profile>> findFollows(String id) =>
      FlutterRepo.getReferenceAndSubCollectionAsStream(
              id, CollectionEnum.users, CollectionEnum.follows)
          .asyncMap<List<Profile>>(
            (profileList) => Future.wait(_mapList(profileList)),
          )
          .asBroadcastStream();

  static Stream<List<Message>> findMessages(String id) =>
      FlutterRepo.getReferenceAndSubCollectionOrderedAsStream(
              id, CollectionEnum.users, CollectionEnum.messages,"time",true )
          .asyncMap<List<Message>>(
            (profileList) => Future.wait(_mapList2(profileList)),
          )
          .asBroadcastStream();

  static Iterable<Future<Profile>> _mapList(
          QuerySnapshot<Map<String, dynamic>> profileList) =>
      profileList.docs.map<Future<Profile>>((m) async {
        var a = await m['user'].get();
        var z = await a['mainImage'].get();
        return _mapProfile(a, z);
      });

  static Iterable<Future<Message>> _mapList2(
          QuerySnapshot<Map<String, dynamic>> profileList) =>
      profileList.docs.map<Future<Message>>((m) async {
        return _mapMessage(m);
      });

  static Future<Message> _mapMessage(m) async {
    var a = await m['from'].get();
    print(a.id);
    var z = await a['mainImage'].get();
    print(z.id);
    Profile user = _mapProfile(a, z);
    return Message(
        m.id,
        m.get("info"),
        m.get("type"),
        m.get("read"),
        m.get("active"),
        m.get("time"),
        user,
        m.get("optional"));
  }

  static _mapProfile(a, z) => Profile(
      a.id,
      a.get('name'),
      a.get('followerCount'),
      a.get('messageCount'),
      a.get('follows'),
      z.get("url"));

  static findUserByRef(String x,ref)async{
    DocumentSnapshot user = await FlutterRepo.getDocSnapOfString(ref);

  }
}
