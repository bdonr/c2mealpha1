import 'package:c2mealpha1/classes/Social.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoggedInSocialCubit extends Cubit<List<Social>>{
  LoggedInSocialCubit():super([]);


  void getSocials(id){
    FlutterRepository.socials(id).listen((event) {
      emit(event);
    });
  }

}