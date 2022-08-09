import 'dart:async';

import 'package:c2mealpha1/classes/Message.dart';
import 'package:c2mealpha1/classes/SocialMedia.dart';
import 'package:c2mealpha1/repository/CollectionEnum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

import 'package:location/location.dart';

import '../classes/MainImage.dart';
import '../classes/Profile.dart';
import '../classes/Social.dart';
import '../enums/SearchCriteria.dart';
import 'Flutter.dart';

class FlutterRepository {
  List<Profile> follower = [];
  late List<SocialMedia> socialList = [
    SocialMedia.ONLYFANS,
    SocialMedia.YOUTUBE,
    SocialMedia.TIKTOK,
    SocialMedia.SNAPCHAT,
    SocialMedia.INSTAGRAM,
    SocialMedia.TWITCH,
    SocialMedia.TWITTER,
    SocialMedia.NOTHING
  ];

  late List<SocialMedia> socialList2 = [];
  late List<List<SocialMedia>> x = [socialList,socialList2];
  late double distance = 15;
  late LocationData locationData;
  late Query<Map<String,dynamic>> query=FirebaseFirestore.instance.collection("users");
  static final FlutterRepository _singleton = FlutterRepository._internal();
  factory FlutterRepository() {
    return _singleton;
  }
  FlutterRepository._internal();

  Stream<List<Social>> socials(uid) {
    return FlutterRepo.getReferenceAndSubCollectionAsStream(
            uid, CollectionEnum.users, CollectionEnum.socials)
        .map((event) => event.docs
            .map((e) => Social(_mapStringToEnum(e.get("type")), e.get('url')))
            .toList());
  }

   Stream<Profile> getProfile(uid) {
    return FlutterRepo.getReferenceOFCollectionAsStream(
            uid, CollectionEnum.users)
        .asyncMap((event) async {
      var z = await event['mainImage'].get();
      return Profile(
          event.id,
          event.get('name'),
          event.get('about') != null ? event.get("about") : "no Info",
          event.get('followerCount'),
          event.get('messageCount'),
          event.get('follows'),
          z.get("url"));
    });
  }

   void changePosition(LocationData locationData, String uid) {
    this.locationData= locationData;
    var geo = new Geoflutterfire();
    GeoFirePoint g = geo.point(
        latitude: locationData.latitude!, longitude: locationData.longitude!);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({'position': g.data});
  }

   Stream<List<Profile>> findUserByLocation(String uid) {
    var geo = new Geoflutterfire();
    GeoFirePoint g = geo.point(
        latitude: locationData.latitude!, longitude: locationData.longitude!);

    return geo
        .collection(collectionRef: query)
        .within(center: g, radius: distance/1000, field: 'position')
        .map((e) => e.where((f) => uid != f.id))
        .asyncMap((event) => Future.wait(event.map((e) async {
              var x = await e["mainImage"].get();
              return Profile(
                  e.id,
                  e.get('name'),
                  e.get('about') != null ? e.get("about") : "no Info",
                  e.get('followerCount'),
                  e.get('messageCount'),
                  e.get('follows'),
                  x.get("url"));
            }).toList()));
  }

   Stream<MainImage> getImage(String id) {
    return FlutterRepo.getReferenceAndSubCollection(
            id, CollectionEnum.users, CollectionEnum.images)
        .where("main", isEqualTo: true)
        .get()
        .then((value) => value.docs.map((e) => MainImage(e.get("url"))).first)
        .asStream();
  }

   Stream<List<Profile>> findFollower(String id) =>
      FlutterRepo.getReferenceAndSubCollectionAsStream(
              id, CollectionEnum.users, CollectionEnum.follower)
          .asyncMap<List<Profile>>(
            (profileList) => Future.wait(_mapList(profileList)),
          )
          .asBroadcastStream();

   Stream<List<Profile>> findFollows(String id) =>
      FlutterRepo.getReferenceAndSubCollectionAsStream(
              id, CollectionEnum.users, CollectionEnum.follows)
          .asyncMap<List<Profile>>(
            (profileList) => Future.wait(_mapList(profileList)),
          )
          .asBroadcastStream();

   Stream<List<Message>> findMessages(String id) =>
      FlutterRepo.getReferenceAndSubCollectionOrderedAsStream(
              id, CollectionEnum.users, CollectionEnum.messages, "time", true)
          .asyncMap<List<Message>>(
            (profileList) => Future.wait(_mapList2(profileList)),
          )
          .asBroadcastStream();

   Iterable<Future<Profile>> _mapList(
          QuerySnapshot<Map<String, dynamic>> profileList) =>
      profileList.docs.map<Future<Profile>>((m) async {
        var a = await m['user'].get();
        var z = await a['mainImage'].get();
        return _mapProfile(a, z);
      });

   Iterable<Future<Message>> _mapList2(
          QuerySnapshot<Map<String, dynamic>> profileList) =>
      profileList.docs.map<Future<Message>>((m) async {
        return _mapMessage(m);
      });

   Future<Message> _mapMessage(m) async {
    var a = await m['from'].get();
    print(a.id);
    var z = await a['mainImage'].get();
    print(z.id);
    Profile user = _mapProfile(a, z);
    return Message(m.id, m.get("info"), m.get("type"), m.get("read"),
        m.get("active"), m.get("time"), user, m.get("optional"));
  }

   _mapProfile(a, z) => Profile(
      a.id,
      a.get('name'),
      a.get('about') != null ? a.get("about") : "no Info",
      a.get('followerCount'),
      a.get('messageCount'),
      a.get('follows'),
      z.get("url"));

   findUserByRef(String x, ref) async {
    DocumentSnapshot user = await FlutterRepo.getDocSnapOfString(ref);
  }

   _mapStringToEnum(String x) {
    if (x == "twitter") {
      return SocialMedia.TWITTER;
    }
    if (x == "xing") {
      return SocialMedia.XING;
    }
    if (x == "facebook") {
      return SocialMedia.FACEBOOK;
    }
    if (x == "twitch") {
      return SocialMedia.TWITCH;
    }
    if (x == "snapshot") {
      return SocialMedia.SNAPCHAT;
    }
    if (x == "pinterest") {
      return SocialMedia.PINTEREST;
    }
    if (x == "onlyfans") {
      return SocialMedia.ONLYFANS;
    }
    if (x == "instagram") {
      return SocialMedia.INSTAGRAM;
    }
    if (x == "tiktok") {
      return SocialMedia.TIKTOK;
    }
    if (x == "youtube") {
      return SocialMedia.YOUTUBE;
    }
    if (x == "blizzard") {
      return SocialMedia.BLIZZARD;
    }
    if (x == "steam") {
      return SocialMedia.STEAM;
    }
  }

  /**
   *
   *[{ field: '[doc].[field name]', operator: '==', value: '[any value]' }]
   */

  nameWhereQueries(String name){
    query = FirebaseFirestore.instance.collection("users").where("name",isEqualTo: name);
  }
  nameGenderWhere(String name,String gender){
    query = FirebaseFirestore.instance.collection("users").where("name",isEqualTo: name).where("gender",isEqualTo: gender);
  }

  genderWhere(String gender){
    query = FirebaseFirestore.instance.collection("users").where("gender",isEqualTo: gender);
  }


  changeRange(double range){
     distance = range;
  }

  standartSearch(){
    query =  FirebaseFirestore.instance.collection("users");
  }


  Stream<List<List<SocialMedia>>> startStream(){
    return Stream.value(x);
  }

  Stream<List<List<SocialMedia>>> swap(SocialMedia muh) async*{
    print(muh);
    x[1].add(x[0].firstWhere((e) => e.name == muh.name));
    x[0].removeWhere((item) => item.name == muh.name);
    yield x;
  }

  Stream<List<List<SocialMedia>>> reset() async*{
   this.socialList = [
      SocialMedia.ONLYFANS,
      SocialMedia.YOUTUBE,
      SocialMedia.TIKTOK,
      SocialMedia.SNAPCHAT,
      SocialMedia.INSTAGRAM,
      SocialMedia.TWITCH,
      SocialMedia.TWITTER,
      SocialMedia.NOTHING
    ];

    this.socialList2 = [];
    this.x=[];
    this.x.add(socialList);
    this.x.add(socialList2);
    yield x;
  }
}
