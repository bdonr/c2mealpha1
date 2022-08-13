import 'dart:async';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Social.dart';

class LoginSocialsCubit extends Cubit<List<Social>> {
  LoginSocialsCubit() : super([]);
  late StreamSubscription subscription;
  List<Social> socials = [];
  final FlutterRepository repository=FlutterRepository();
  void getSocials(uid) {
    repository.socials().listen((event) {
      event.forEach((element) {
        socials.add(element);
      });
      emit(socials.toList());
    });
  }
}
