import 'package:cloud_firestore/cloud_firestore.dart';

class Station {
  late DocumentReference reference;
  late List stationsReference;
  late GeoPoint location;
  late String name;
  late String group;
  late String description;
  late String image;
  late int users;
  late double distance;

  Station.setFromFireStore(DocumentSnapshot? snapshot) {
    Map map = snapshot!.data() as Map;
    reference = snapshot.reference;
    stationsReference = map['stations'];
    location = map['location'];
    name = map['name'];
    group = map['group'];
    description = map['description'];
    image = map['image'];
    users = map['users'];
  }
}