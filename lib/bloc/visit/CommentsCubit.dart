import 'package:c2mealpha1/classes/Comment.dart';
import 'package:c2mealpha1/repository/MessageRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsCubit extends Cubit<List<Comment>>{
  final MessageRepository messageRepository = MessageRepository();
  CommentsCubit():super([]);

  visit(DocumentReference ref){
    print("hier"+ref.toString());
    messageRepository.findCommentsOfRef(ref).listen((event) {
      emit(event);
    });
  }
}