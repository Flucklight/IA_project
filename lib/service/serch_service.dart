import 'package:ia_project/model/induvidual.dart';
import 'package:ia_project/model/station.dart';

List<Individual> _population = [];

void genPol(Station start, Station end, int popLength, List<Station> stations) {
  while (_population.length < popLength) {
    _population.add(Individual(start: start, end: end, stations: stations));
  }
}

void crossOver(List<Station> stations) {
  for (int i = 0; i < _population.length/2; i++) {
    _population.removeAt(_population.length - (i + 1));
    _population.add(_population.elementAt(i).clone(stations));
  }
}

double popAverage() {
  num average = 0;
  for (var ind in _population) {
    average += ind.grade;
  }
  return average/_population.length;
}

void selection() {
  _population.sort((a, b) => a.grade.compareTo(b.grade));
}

List<Station> search(popLength, genAverage, List<Station> stations, Station dest) {
  stations.sort((a, b) => a.distance.compareTo(b.distance));
  genPol(stations.first, dest, popLength, stations);
  List<double> genMemory = [];
  double memAverage = 0;
  double average = 0;
  while (true) {
    genMemory.add(popAverage());
    if (genMemory.length > genAverage) {
      genMemory.removeAt(0);
      memAverage = average;
      average = 0;
      for (var mem in genMemory) {
        average += mem;
      }
      average = average/genMemory.length;
      if (memAverage == average) {
        break;
      }
    }
    selection();
    crossOver(stations);
  }
  return _population.first.gen;
}
