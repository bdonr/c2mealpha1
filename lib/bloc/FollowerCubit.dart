import 'dart:async';
import 'dart:math';

import 'package:c2mealpha1/repository/FlutterRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';
import '../repository/PersonRepository.dart';

class FollowerCubit extends Cubit<List<Profile>> {
  PersonRepository repo = new PersonRepository();
  late StreamSubscription c;

  FollowerCubit():super([]);

  List<Profile> p = [];
  void get(String id) {
    FlutterRepository.findFollower(id).listen((event) {
      print("triggeret");
      print(p.length);
      event.forEach((element) {
        p.add(element);
      });
      emit(p.toList());
    });
  }
}
