import 'package:ia_project/model/station.dart';
import 'package:ia_project/service/file_service.dart';
import 'package:ia_project/service/math.dart';

class UserLocation {
  double latitude;
  double longitude;
  final FileManager _checkerData = FileManager();
  late String _checker;
  late Station _state;

  UserLocation({required this.longitude, required this.latitude});

  void setChecker(List<Station> stations) {
    _checkerData.readChecker().then((value) {
      _checker = value;
      if (_checker.isNotEmpty) {
        for (var element in stations) {
          if (_checker == element.name) {
            _state = element;
            break;
          }
        }
      }
    });
  }

  void _updateChecker(String station) {
    _checker = station;
    _checkerData.writeChecker(_checker);
  }

  void _updateState(Station station) {
    _state = station;
    _state.reference.update({'users': _state.users + 1});
  }

  void checkPosition(List<Station> stations) {
    for (var element in stations) {
      element.distance = haversineEquation(element.location.longitude, element.location.latitude, longitude, latitude);
      if (element.distance <= 500) {
        if (_checker.isEmpty) {
          _updateState(element);
          _updateChecker(element.name);
        } else if (_checker != element.name) {
          _state.reference.update({'users': _state.users - 1});
          _updateState(element);
          _updateChecker(element.name);
        }
      } else {
        if (_checker == element.name) {
          _state.reference.update({'users': _state.users - 1});
          _updateChecker('');
        }
      }
    }
  }
}
