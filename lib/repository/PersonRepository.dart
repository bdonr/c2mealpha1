import 'dart:async';
import 'dart:math';

import '../classes/Profile.dart';

class PersonRepository {
  static List<Profile> near = [];
  static List<Profile> follow = [];
  static List<Profile> follows = [];
  static List<Profile> _users = [];


  List<Profile> get users => _users;

  set users(List<Profile> value) {
    _users = value;
  }

  static Stream<List<Profile>> nearProfile(int k, int min) async* {
    var intValue = Random().nextInt(_users.length-1);
    while (near.length < min) {
      await Future.delayed(const Duration(milliseconds: 1));
      if (intValue != k) {
        near.add(_users
            .where((element) => element.id == intValue)
            .first);
        yield near;
      }
      else {
        intValue = Random().nextInt(_users.length-1);
      }
    }
  }


  static Stream<List<Profile>> followerProfile(int k, int min) async* {
    var intValue = Random().nextInt(_users.length-1);
    print(intValue);
    while (follow.length < min) {
      await Future.delayed(const Duration(milliseconds: 1));
      if (intValue != k) {
        follow.add(_users
            .where((element) => element.id == intValue)
            .first);
        yield follow;
      }
      else {
        print("follow"+intValue.toString());

        intValue = Random().nextInt(_users.length-1);
      }
    }
  }






  static Stream<List<Profile>> followsProfile(int k, int min) async* {
    var intValue = Random().nextInt(_users.length-1);
    print(intValue);
    while (follows.length < min) {
      await Future.delayed(const Duration(milliseconds: 1));
      if (intValue != k) {
        follows.add(_users
            .where((element) => element.id == intValue)
            .first);
        yield follows;
      }
      else {
        print("follow"+intValue.toString());

        intValue = Random().nextInt(_users.length-1);
      }
    }
  }




}
