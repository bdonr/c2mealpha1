import 'dart:async';

import 'package:c2mealpha1/repository/FlutterRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';
import '../repository/PersonRepository.dart';

class FollowerCubit extends Cubit<List<Profile>> {
  PersonRepository repo = new PersonRepository();
  late StreamSubscription c;

  FollowerCubit():super([]);


  void get() async{

  }
}
