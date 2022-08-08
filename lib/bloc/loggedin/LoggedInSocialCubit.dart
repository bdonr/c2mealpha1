import 'package:c2mealpha1/classes/Social.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoggedInSocialCubit extends Cubit<List<Social>>{
  LoggedInSocialCubit():super([]);
  final FlutterRepository repository=FlutterRepository();

  void getSocials(id){
    repository.socials(id).listen((event) {
      emit(event);
    });
  }

}