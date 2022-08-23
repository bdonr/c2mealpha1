import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Story.dart';

class StoriesCubit extends Cubit<List<Story>>{
  StoriesCubit():super([]);
  final MessageRepository repository = MessageRepository();
  visit(DocumentReference reference){
    print("sdasda"+reference.toString());
    repository.findStoriesOfUser(reference).listen((event) {
      print(event);
      emit(event);
    });
  }
}