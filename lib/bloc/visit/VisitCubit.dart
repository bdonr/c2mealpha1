import 'dart:async';

import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Profile.dart';

class VisitCubit extends Cubit<Profile?> {
  VisitCubit() : super(null);
  final FlutterRepository repository=FlutterRepository();
  late StreamSubscription x;

  void findProfile(String id){
    repository.getProfile(id).listen((event) {
      emit(event);
    });
  }
}
