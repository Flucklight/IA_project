import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ia_project/model/location.dart';
import 'package:ia_project/model/station.dart';

class HomePage extends StatelessWidget {
  final List<Station> stations;
  final UserLocation userLocation;
  const HomePage(this.stations, this.userLocation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Station> show = [];
    int index = 0;

    for (var station in stations) {
      if (index < 4){
        show.add(station);
        index++;
      } else {
        break;
      }
    }

    return ListView(children: show.map((station) {
      double d;
      String D;

      if (station.distance > 1000) {
        d = station.distance / 100;
        d = d.truncate() / 10;
        D = d.toString() + " km";
      } else {
        D = station.distance.truncate().toString() + " mts";
      }

      MaterialColor colorDesignation() {
        if (station.users < 34) {
          return Colors.green;
        } else if (station.users < 68) {
          return Colors.yellow;
        } else {
          return Colors.red;
        }
      }

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: 162,
        width: double.maxFinite,
        child: Card(
          color: const Color(0xffb2b2b1),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Stack(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    alignment: FractionalOffset.centerLeft,
                    child: Image(
                        image: NetworkImage(station.image),
                        height: 105,
                        width: 95)),
                Container(
                  padding: const EdgeInsets.fromLTRB(110.0, 10.0, 10.0, 10.0),
                  constraints: const BoxConstraints.expand(),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          station.name,
                        ),
                        Container(
                          height: 4.0,
                        ),
                        Text(
                          station.description,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          height: 2.0,
                          width: 18.0,
                          color: const Color(0xffaf1e00),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.blueAccent,
                                      ),
                                      Container(
                                        width: 4.0,
                                      ),
                                      Text(D),
                                    ],
                                  ),
                                  Container(
                                    width: 4.0,
                                  ),
                                  Icon(Icons.accessibility,
                                      color: colorDesignation()),
                                  Container(
                                    width: 4.0,
                                  ),
                                  Text(station.users.toString()),
                                  Container(
                                    width: 4.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }).toList());
  }
}
