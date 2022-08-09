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

  reset(){
    x = repository.reset().listen((event) {});
    x.onData((data) {
      print(data);
      emit(data);
    });
  }
}
