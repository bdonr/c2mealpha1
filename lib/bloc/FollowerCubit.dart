import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';
import '../repository/PersonRepository.dart';

class FollowerCubit extends Cubit<List<Profile>> {
  PersonRepository repo = new PersonRepository();
  late StreamSubscription c;

  FollowerCubit():super([]);


  void get() async{
    c = PersonRepository.followerProfile(1, 10000000).listen((event) {
      emit (event.map((e) => e).toList());
    });
  }
}
