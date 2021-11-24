import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ia_project/model/station.dart';

class Individual {
  List<Station> gen = [];
  int transshipment = 0;
  num grade = 0;

  Individual({Station? start, Station? end, List<Station>? stations, bool clone = false, List<Station>? gen}) {
    if (!clone) {
      genCode(start!, end!, stations!);
    } else {
      this.gen.addAll(gen!);
      mute(stations!);
    }
  }

  void genCode(Station head, Station tail, List<Station> stations) {
    Station pointer = head;
    DocumentReference backtrack = pointer.reference;
    List<Station> varGen = [];
    DocumentReference ref;
    bool cycle = false;
    int next;
    while (varGen.length <= stations.length && !cycle) {
      varGen.add(pointer);
      if (pointer == tail) {
        break;
      }
      next = Random.secure().nextInt(pointer.stationsReference.length);
      ref = pointer.stationsReference.elementAt(next);
      if (backtrack == ref) {
        if (next == pointer.stationsReference.length - 1) {
          next--;
        } else {
          next++;
        }
        ref = pointer.stationsReference.elementAt(next);
      }
      for (var station in stations) {
        if (ref == station.reference) {
          backtrack = pointer.reference;
          pointer = station;
          break;
        }
      }
      cycle = varGen.contains(pointer);
    }
    gen.addAll(varGen);
    evaluation(cycle);
  }

  void mute(List<Station> stations) {
    Station end = gen.last;
    int muteVar = Random.secure().nextInt(gen.length);
    gen = gen.sublist(0, muteVar);
    genCode(gen.last, end, stations);
  }

  Individual clone(List<Station> stations) {
    return Individual(stations: stations, clone: true, gen: gen);
  }

  void evaluation(bool cycle) {
    String memoryGroup = gen.first.group;
    int population = 0;
    int exponent;
    transshipment = 0;
    if (cycle) {
      exponent = 2;
    } else {
      exponent = 1;
    }
    for (var station in gen) {
      population += station.users;
      if (memoryGroup != station.group) {
        transshipment++;
        memoryGroup = station.group;
      }
    }
    grade = pow(gen.length, exponent) + transshipment + population;
  }
}
