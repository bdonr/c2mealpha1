import 'dart:async';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Profile.dart';

class DoIFollowCubit extends Cubit<bool>{
  final FlutterRepository repository = FlutterRepository();
  late StreamSubscription subscription;
  DoIFollowCubit():super(false);


  areWeFollower(Profile profile){
    repository.areWeFriends(profile).listen((event) {
    });
  }
}