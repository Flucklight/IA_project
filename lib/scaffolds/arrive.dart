import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ia_project/model/location.dart';
import 'package:ia_project/model/station.dart';

class ArrivePage extends StatelessWidget {
  final List<Station> stations;
  final UserLocation userLocation;
  const ArrivePage(this.stations, this.userLocation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userLocation.checker.isNotEmpty) {
      return _inStation(context, userLocation.state);
    } else {
      return _outStation();
    }
  }

  Widget _inStation(BuildContext context, Station station) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.doc('metros/' + station.group + 'M1').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            Map metro = snapshot.data!.data() as Map;
            String arrive = '';
            for (var element in stations) {
              if(element.reference == metro['arrive']) {
                arrive = element.name;
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image(
                  image: NetworkImage(station.image),
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 40),
                Text('Estacion ' + station.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54)),
                const SizedBox(height: 10),
                Text('Metro en la estacion: ' + arrive, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54)),
                const SizedBox(height: 10),
                Text('Ocupantes: ' + metro['occupants'].toString(), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54)),
                const SizedBox(height: 10)
              ]
            );
          } else {
            return const CupertinoActivityIndicator();
          }
        });
  }

  Widget _outStation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: const [
        Text('No hay llegadas en su posicion', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54)),
        SizedBox(height: 40)
      ],
    );
  }
}
