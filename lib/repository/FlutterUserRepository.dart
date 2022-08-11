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
  late List<List<SocialMedia>> x = [socialList, socialList2];
  late double distance = 15;
  bool exact = false;
  bool anyRes = true;
  late LocationData locationData;
  late StreamSubscription<List<Profile>> geosub;
  late Query<Map<String, dynamic>> query =
      FirebaseFirestore.instance.collection("users");
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
      return mapProfile(event, z);
    });
  }

  void changePosition(LocationData locationData, String uid) {
    this.locationData = locationData;
    var geo = new Geoflutterfire();
    GeoFirePoint g = geo.point(
        latitude: locationData.latitude!, longitude: locationData.longitude!);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({'position': g.data});
  }

  Stream<List<Profile?>> findUserByLocation(String uid) {
    final geo = new Geoflutterfire();
    GeoFirePoint g = geo.point(
        latitude: locationData.latitude!, longitude: locationData.longitude!);
    return geo
        .collection(collectionRef: query)
        .within(center: g, radius: distance, field: 'position')
        .map((e) => e.where((f) => uid != f.id))
        .asyncMap((event) => Future.wait(event.map((u) async {
              var x = await u["mainImage"].get();
              if (this.x[1].isNotEmpty) {
                int res = await filterBySocialMedia(u);
                if (exact && res==this.x[1].length) {
                  return mapProfile(u, x);
                }
                if (anyRes && res>=1) {
                  return mapProfile(u, x);
                }
                return null;
              }
              return mapProfile(u, x);
            })));
  }

  Profile mapProfile(DocumentSnapshot<Map<String, dynamic>> u, x) {
    return Profile(
        u.id,
        u.get('name'),
        u.get('about') != null ? u.get("about") : "no Info",
        u.get('followerCount'),
        u.get('messageCount'),
        u.get('follows'),
        x.get("url"));
  }

  Future<int> filterBySocialMedia(
      DocumentSnapshot<Map<String, dynamic>> u) async {
    List<String>tmpsociallist =x[1].map((e) => e.name.toLowerCase()).toList();
    print(tmpsociallist);
    QuerySnapshot y = await FirebaseFirestore.instance
        .collection("users")
        .doc(u.id)
        .collection("socials").where("type",whereIn: tmpsociallist).get();
    return y.docs.map((e) => e.get("type").toString()).length;

  }

  bool filterOnly(List<String> tmpsociallist){
    return (tmpsociallist.length==tmpsociallist.length);
  }


  bool filterAny(List<String> tmpsociallist){
    return (tmpsociallist.length>1);
  }

  Future<int> filterBySocialMediaOLD(DocumentSnapshot<Map<String,dynamic>>u,x) async {
    var y = await FirebaseFirestore.instance
        .collection("users")
        .doc(u.id)
        .collection("socials")
        .get();
    return y.docs.map((element) => element.get("type").toString()).toList().length;
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
    var z = await a['mainImage'].get();
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

  nameWhereQueries(String name) {
    query = FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: name);
  }

  nameGenderWhere(String name, String gender) {
    query = FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: name)
        .where("gender", isEqualTo: gender);
  }

  genderWhere(String gender) {
    query = FirebaseFirestore.instance
        .collection("users")
        .where("gender", isEqualTo: gender);
  }

  changeRange(double range) {
    distance = range;
  }

  standartSearch() {
    query = FirebaseFirestore.instance.collection("users");
  }

  Stream<List<List<SocialMedia>>> startStream() async* {
    yield x;
  }

  Stream<List<List<SocialMedia>>> swap(SocialMedia muh) async* {
    x[1].add(x[0].firstWhere((e) => e.name == muh.name));
    x[0].removeWhere((item) => item.name == muh.name);
    yield x;
  }

  Stream<List<List<SocialMedia>>> reset() async* {
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
    this.x = [];
    this.x.add(socialList);
    this.x.add(socialList2);
    yield x;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> possible(
      CollectionReference<Map<String, dynamic>> k) {
    for (var element in x[1]) {
      if (element == SocialMedia.ONLYFANS) {
        k..where("type", isEqualTo: "onlyfans");
      }
      if (element == SocialMedia.YOUTUBE) {
        k..where("type", isEqualTo: "youtube");
      }
      if (element == SocialMedia.TIKTOK) {
        k..where("type", isEqualTo: "tiktok");
      }
      if (element == SocialMedia.SNAPCHAT) {
        k..where("type", isEqualTo: "snapchat");
      }
      if (element == SocialMedia.INSTAGRAM) {
        k..where("type", isEqualTo: "instagram");
      }
      if (element == SocialMedia.TWITCH) {
        k..where("type", isEqualTo: "twitch");
      }
      if (element == SocialMedia.TWITTER) {
        k..where("type", isEqualTo: "twitter");
      }
    }
    return k.get();
  }
}
