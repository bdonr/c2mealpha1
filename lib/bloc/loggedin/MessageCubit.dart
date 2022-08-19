import 'dart:async';

import 'package:c2mealpha1/classes/Message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/FlutterUserRepository.dart';

class MessageCubit extends Cubit<List<NotificationMessage>> {
  late StreamSubscription c;
  final FlutterRepository repository=FlutterRepository();
  MessageCubit():super([]);

  List<NotificationMessage> p = [];
  void getMessages(String id) {
    c = repository.findMessages().listen((event) {});
    c.onData((data) {
      emit(data);
    });

  }
}
