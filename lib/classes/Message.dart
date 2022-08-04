import 'dart:ffi';

import 'package:c2mealpha1/classes/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/**
 *     info: info,
    type: type,
    read: false,
    time: _getTime(),
    active: true,
    optional: optional,
 */


class Message {
  final String id;
  final String info;
  final String type;
  final bool read;
  final bool active;
  final Timestamp time;
  final Profile from;
  late List<dynamic>optional;

  Message(this.id, this.info, this.type, this.read, this.active, this.time,
      this.from, this.optional);
}