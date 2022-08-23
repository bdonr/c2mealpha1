
import 'package:c2mealpha1/classes/Comment.dart';
import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<Comment?>{
  MessageRepository messageRepository = MessageRepository();
  CommentCubit():super(null);

  visit(DocumentReference reference){
    messageRepository.findComment(reference).listen((event) {
      emit(event);
    });
  }

}