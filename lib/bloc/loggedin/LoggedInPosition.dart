import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;

class LoggedInPosition extends Cubit<Stream<LocationData>> {
  static StreamController<LocationData> _locationController =
      StreamController<LocationData>();

  static Location location = Location();

  LoggedInPosition() : super(locationStream) {
    _determinePosition();
  }

  static Stream<LocationData> get locationStream => _locationController.stream;

  void _determinePosition() async {
    location.changeSettings(interval:5000,distanceFilter: 15);
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
    print(location);
    location.onLocationChanged.listen((locationData) {
        _locationController.add(locationData);

    });
  }
}
