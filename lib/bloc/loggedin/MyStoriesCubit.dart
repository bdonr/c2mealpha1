import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Story.dart';

class MyStoriesCubit extends Cubit<List<Story>>{
  final MessageRepository repository = MessageRepository();
  MyStoriesCubit():super([]){
    repository.findStoriesOfLoggedUser()?.listen((event) {
      print(event);
      emit(event);
    });
  }

}