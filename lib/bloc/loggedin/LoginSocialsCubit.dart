import 'dart:async';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Social.dart';

class LoginSocialsCubit extends Cubit<List<Social>> {
  LoginSocialsCubit() : super([]);
  late StreamSubscription subscription;
  List<Social> socials = [];

  void getSocials(uid) {
    FlutterRepository.socials(uid).listen((event) {
      event.forEach((element) {
        socials.add(element);
      });
      emit(socials.toList());
    });
  }
}
