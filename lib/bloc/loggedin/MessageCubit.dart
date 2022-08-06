import 'dart:async';

import 'package:c2mealpha1/classes/Message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/FlutterUserRepository.dart';

class MessageCubit extends Cubit<List<Message>> {
  late StreamSubscription c;

  MessageCubit():super([]);

  List<Message> p = [];
  void getMessages(String id) {
    c = FlutterRepository.findMessages(id).listen((event) {});
    c.onData((data) {
      emit(data);
    });

  }
}