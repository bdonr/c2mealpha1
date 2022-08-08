
import 'dart:async';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/repository/PersonRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Profile.dart';

class FollowsCubit extends Cubit<List<Profile?>>{
  late StreamSubscription c;
  FollowsCubit():super([]);
  final FlutterRepository repository=FlutterRepository();
  void getFollows(String id){
    c = repository.findFollows(id).listen((event) {});
    c.onData((data) {
      emit(data);
    });
  }




}