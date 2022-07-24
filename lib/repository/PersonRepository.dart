import 'dart:async';
import 'dart:math';

import '../classes/Profile.dart';

class PersonRepository {
  static List<Profile> near = [];
  static List<Profile> follow = [];
  static List<Profile> follows = [];
  static List<Profile> _users = [
    Profile(
        "Sabrina",
        "https://mindjazz-pictures.de/wp-content/uploads/2020/06/Woman_header_Still0-1440x810.jpg",
        1),
    Profile(
        "Sarah",
        "https://media.gettyimages.com/photos/beauty-portrait-of-young-woman-picture-id1309405076?s=612x612",
        2),
    Profile(
        "Jenny1",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        3),
    Profile(
        "Jenny2",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        4),
    Profile(
        "Jenny3",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        5),
    Profile(
        "Jenny4",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        6),
    Profile(
        "Jenny5",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        7),
    Profile(
        "Jenny6",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        8),
    Profile(
        "Jenny7",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        9),
    Profile(
        "Jenny8",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        10),
    Profile(
        "Jenny9",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
       11),
    Profile(
        "Jenny10",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        12),
    Profile(
        "Jenny11",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        13)
  ];

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
