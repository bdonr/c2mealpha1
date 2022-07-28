import 'dart:async';
import 'dart:math';

import 'package:c2mealpha1/repository/FlutterRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';
import '../repository/PersonRepository.dart';

class FollowerCubit extends Cubit<List<Profile>> {
  late StreamSubscription c;

  FollowerCubit():super([]);

  List<Profile> p = [];
  void get(String id) {
     c = FlutterRepository.findFollower(id).listen((event) {});
     c.onData((data) {
       emit(data);
     });

  }
}
