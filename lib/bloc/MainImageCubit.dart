import 'dart:async';

import 'package:c2mealpha1/classes/MainImage.dart';
import 'package:c2mealpha1/repository/FlutterRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/StartPage.dart';

class LoggedInImageCubit extends Cubit<ProfileImageHeader?>{
  LoggedInImageCubit():super(null);
  late StreamSubscription subscription;
  getImage(uid){
    subscription = FlutterRepository.getImage(uid).listen((event) {
      print(event.toString());
      emit(ProfileImageHeader(event.url));
    });
  }

}