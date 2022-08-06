import 'dart:async';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Social.dart';

class SocialsCubit extends Cubit<List<Social>>{
  SocialsCubit():super([]);
  late StreamSubscription subscription;

  void getSocials(uid){
    List<Social> socials = [];
    FlutterRepository.socials(uid).listen((event) {
      event.forEach((element) {
        socials.add(element);
      });
      emit(socials.toList());
    });
  }


}