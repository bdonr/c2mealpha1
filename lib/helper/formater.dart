import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Formater{

  static String func(int i) {
    if (i > 999 && i < 999999) {
      return _roundDouble(i / 1000, 3) + "k";
    }
    if (i > 1000000 && i < 999999999) {
      return _roundDouble(i / 1000000, 3) + "M";
    }
    if (i > 1000000000) {
      return _roundDouble(i / 1000000000, 3) + "B";
    }
    if(i%10==0){

    }
    return i.toInt().toString();
  }

  static String _roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    String text = ((value * mod).round().toDouble() / mod).toStringAsFixed(places);
    return (text.toString());
  }

  static String timeToString(Timestamp x){
    final DateTime dateTime = x.toDate();
    final dateString = DateFormat('K:mm').format(dateTime.toLocal());
    return dateString;
  }
}