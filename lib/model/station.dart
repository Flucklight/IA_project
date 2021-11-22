import 'package:cloud_firestore/cloud_firestore.dart';

class Station {
  late DocumentReference reference;
  late List stationsReference;
  late Map<String, dynamic> lines;
  late GeoPoint location;
  late String name;
  late String description;
  late String image;
  late int users;
  late Station path;
  late double distance;

  Station.setFromFireStore(DocumentSnapshot? snapshot) {
    Map map = snapshot!.data() as Map;
    reference = snapshot.reference;
    stationsReference = map['stations'];
    lines = map['lines'];
    location = map['location'];
    name = map['name'];
    description = map['description'];
    image = map['image'];
    users = map['users'];
  }
}