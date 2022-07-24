import 'dart:async';

import 'package:c2mealpha1/classes/MainImage.dart';
import 'package:c2mealpha1/repository/FlutterRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainImageCubit extends Cubit<MainImage?>{
  MainImageCubit():super(null);
  late StreamSubscription subscription;
  getImage(uid){
    subscription = FlutterRepository.getImage(uid).listen((event) {
      print(event.toString());
      emit(MainImage(event.url));
    });
  }

}