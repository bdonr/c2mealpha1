import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';
import '../repository/PersonRepository.dart';

class NearCubit extends Cubit<List<Profile>> {
  PersonRepository repo = new PersonRepository();
  late StreamSubscription c;

  NearCubit():super([]);

  void get() async{
    c = PersonRepository.test(2, 29).listen((event) {
        emit (event.map((e) => e).toList());
    });
  }
}
