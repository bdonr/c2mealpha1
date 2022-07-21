import 'dart:async';
import 'dart:math';

import '../classes/Profile.dart';

class PersonRepository {
  static List<Profile> near = [];
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
        "Jenny",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        3),
    Profile(
        "Jenny",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        4),
    Profile(
        "Jenny",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        5),
    Profile(
        "Jenny",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        6),
    Profile(
        "Jenny",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        7),
    Profile(
        "Jenny",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        8),
    Profile(
        "Jenny",
        "https://media.vogue.fr/photos/5d2c4510c9cf700008f68f3c/3:2/w_1439,h_959,c_limit/D4_6SNzWwAAyAfV.jpg",
        9)
  ];

  List<Profile> get users => _users;

  set users(List<Profile> value) {
    _users = value;
  }

  static Stream<List<Profile>> test(int k, int min) async* {
    var intValue = Random().nextInt(_users.length);
    while (near.length < min) {
      await Future.delayed(const Duration(seconds: 2));
      if (intValue != k) {
        near.add(_users[intValue]);
        yield near;
      }
      else{
        intValue = Random().nextInt(_users.length);
      }
    }
  }


  static Stream<List<Profile>> test2(int k, int min) async* {
    while (near.length < min) {
      await Future.delayed(const Duration(seconds: 2));
      var intValue = Random().nextInt(_users.length);
      if (intValue != k) {
        near.add(_users[intValue]);
        yield near;
      }
    }
  }
}
