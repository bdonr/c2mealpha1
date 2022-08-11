import 'dart:async';

import 'package:c2mealpha1/classes/SocialMedia.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialSearchCubit extends Cubit<List<List<SocialMedia>>> {
  final FlutterRepository repository = FlutterRepository();
  late StreamSubscription x;
  late List<SocialMedia> swapItems=[];
  SocialSearchCubit() : super([]);

  start(){
    x = repository.startStream().listen((event) {});
    x.onData((data) {
      print(data);
      emit(data);
    });
  }
  swap(SocialMedia muh) {
    x = repository.swap(muh).listen((event) {});
    x.onData((data) {
      print(data);
      emit(data);
    });
  }

  swapOtherDirection(SocialMedia muh) {
    x = repository.swapOtherDirection(muh).listen((event) {});
    x.onData((data) {
      print(data);
      emit(data);
    });
  }


  reset(){
    x = repository.reset().listen((event) {});
    x.onData((data) {
      print(data);
      emit(data);
    });
  }

  setExact(){
    repository.exact=!repository.exact;
    repository.anyRes=!repository.anyRes;
  print(repository.anyRes);
  print(repository.exact);

  }

}
