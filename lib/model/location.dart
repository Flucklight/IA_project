import 'package:ia_project/model/station.dart';
import 'package:ia_project/service/file_service.dart';
import 'package:ia_project/service/math.dart';

class UserLocation {
  double latitude;
  double longitude;
  final FileManager _checkerData = FileManager();
  late String checker;
  late Station state;

  UserLocation({required this.longitude, required this.latitude});

  void setChecker(List<Station> stations) {
    _checkerData.readChecker().then((value) {
      checker = value;
      if (checker.isNotEmpty) {
        for (var element in stations) {
          if (checker == element.name) {
            state = element;
            break;
          }
        }
      }
    });
  }

  void _updateChecker(String station) {
    checker = station;
    _checkerData.writeChecker(checker);
  }

  void _updateState(Station station) {
    state = station;
    state.reference.update({'users': state.users + 1});
  }

  void checkPosition(List<Station> stations) {
    for (var element in stations) {
      element.distance = haversineEquation(element.location.longitude, element.location.latitude, longitude, latitude);
      if (element.distance <= 500) {
        if (checker.isEmpty) {
          _updateState(element);
          _updateChecker(element.name);
        } else if (checker != element.name) {
          state.reference.update({'users': state.users - 1});
          _updateState(element);
          _updateChecker(element.name);
        }
      } else {
        if (checker == element.name) {
          state.reference.update({'users': state.users - 1});
          _updateChecker('');
        }
      }
    }
  }
}
