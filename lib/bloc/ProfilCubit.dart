import 'dart:async';

import 'package:c2mealpha1/classes/Social.dart';
import 'package:c2mealpha1/classes/SocialMedia.dart';
import 'package:c2mealpha1/events/ProfileEvent.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:c2mealpha1/repository/PersonRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/Profile.dart';
import '../states/ProfileState.dart';

class ProfilCubit extends Cubit<Profile?> {
  late StreamSubscription streamSubscription;
  ProfilCubit() : super(null);

  void getProfile(String id) async{
    streamSubscription = FlutterRepository.getProfile(id).listen(
            (event)=> emit(event));
 }


}

