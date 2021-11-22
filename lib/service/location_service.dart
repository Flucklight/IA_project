import 'dart:async';

import 'package:location/location.dart';
import 'package:ia_project/model/location.dart';

class LocationService {
  final Location _location = Location();
  late UserLocation _currentLocation;

  final StreamController<UserLocation> _locationController = StreamController.broadcast();
  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    _location.requestPermission().then((value) {
      if (value == PermissionStatus.granted) {
        _location.onLocationChanged.listen((event) {
          _locationController.add(UserLocation(latitude: event.latitude!, longitude: event.longitude!));
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await _location.getLocation();
      _currentLocation = UserLocation(latitude: userLocation.latitude!, longitude: userLocation.longitude!);
    } catch (e) {
      print('Could not get the location $e');
    }
    return _currentLocation;
  }

}
