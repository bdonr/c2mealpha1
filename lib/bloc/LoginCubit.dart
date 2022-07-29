import 'package:c2mealpha1/classes/Profile.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<Profile?>{
  LoginCubit():super(null);

  void login(String id){

    FlutterRepository.getProfile(id).listen((event) {
      emit(event);
    });
  }
}