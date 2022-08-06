import 'dart:async';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Profile.dart';

class VisitCubit extends Cubit<Profile?> {
  VisitCubit() : super(null);

  late StreamSubscription x;

  void findProfile(String id){
    FlutterRepository.getProfile(id).listen((event) {
      emit(event);
    });
  }
}
