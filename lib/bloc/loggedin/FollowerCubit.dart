import 'dart:async';
import 'dart:math';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Profile.dart';
import '../../repository/PersonRepository.dart';

class FollowerCubit extends Cubit<List<Profile>> {
  late StreamSubscription c;
  final FlutterRepository repository=FlutterRepository();
  FollowerCubit():super([]);

  List<Profile> p = [];
  void getFollower(String id) {
     c = repository.findFollower(id).listen((event) {});
     c.onData((data) {
       emit(data);
     });

  }
}
