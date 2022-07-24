import 'dart:math';

class Formater{

  static String func(double i) {
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
}