import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../classes/Story.dart';

class StoryCubit extends Cubit<Story?>{

  final MessageRepository repository=MessageRepository();
  StoryCubit() : super(null);
  visit(DocumentReference id){
    repository.findStory(id).listen((event) {
      emit(event);
    });
  }

}