import 'dart:async';
import 'package:geoflutterfire/src/util.dart';
import 'package:c2mealpha1/repository/FlutterUserRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:rxdart/rxdart.dart';
import '../../classes/Profile.dart';

class LoggedInPosition extends Cubit<List<Profile>> {

  static Location location = Location();

  late String uid;
  late StreamSubscription c;
  LoggedInPosition(String uidd) : super([]) {
    uid = uidd;
    _determinePosition();
    location.changeSettings(interval: 1000, distanceFilter: 15);
  }


  void _determinePosition() async {
    bool serviceEnabled;
    // Test if location services are enabled.
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await location.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          return;
        }
      }
    }
    location.onLocationChanged.listen((locationData) {
      FlutterRepository.changePosition(locationData, uid);
      FlutterRepository.findUserByLocation(locationData, uid).listen((event){
        emit(event);
      });
    });
  }
}
