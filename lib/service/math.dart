import 'dart:math';

double haversineEquation(longitude_1, latitude_1, longitude_2, latitude_2) {
  double lat1 = _radiansFromDegrees(latitude_1);
  double lon1 = _radiansFromDegrees(longitude_1);
  double lat2 = _radiansFromDegrees(latitude_2);
  double lon2 = _radiansFromDegrees(longitude_2);
  double earthRadius = 6378137.0;
  return 2 * earthRadius * asin(sqrt(pow(sin(lat2 - lat1) / 2, 2) + cos(lat1) * cos(lat2) * pow(sin(lon2 - lon1) / 2, 2)));
}

double _radiansFromDegrees(final double degrees) => degrees * (pi / 180.0);