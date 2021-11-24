import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ia_project/model/location.dart';
import 'package:ia_project/model/station.dart';
import 'package:ia_project/service/serch_service.dart';

class HomePage extends StatefulWidget {
  final List<Station> stations;
  final UserLocation userLocation;
  const HomePage(this.stations, this.userLocation, {Key? key})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool travel = false;
  List<Station> path = [];
  late Station dest;

  @override
  Widget build(BuildContext context) {
    late List<Widget> view = [];
    if (travel) {
      path = search(10, 10, widget.stations, dest);
      view.addAll(path.map((station) {return Image(image: NetworkImage(station.image));}).toList());
      view.add(FloatingActionButton.extended(
        onPressed: () => setState(() {travel = false;}),
        backgroundColor: const Color(0xff838382),
        label: const Text('Volver'),
      ));
      return ListView(children: view);
    } else {
      return ListView(
          children: widget.stations.map((station) {
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
                                    CupertinoButton(
                                      child: const Text(
                                        "Viajar",
                                        style: TextStyle(
                                            color: Color(0xffaf1e00),
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onPressed: () => setState(() {
                                        dest = station;
                                        travel = true;
                                      }),
                                    )
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
}
