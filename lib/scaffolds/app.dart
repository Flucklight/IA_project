import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ia_project/model/location.dart';
import 'package:ia_project/model/station.dart';
import 'package:ia_project/scaffolds/arrive.dart';
import 'package:ia_project/scaffolds/home.dart';
import 'package:ia_project/scaffolds/profile.dart';
import 'package:ia_project/service/location_service.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Station> _stations = [];
  final UserLocation _userLocation = UserLocation(longitude: 0, latitude: 0);
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return _getData(context);
  }

  Widget _getData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('stations').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _stations.clear();
          for (var element in snapshot.data!.docs) {
            _stations.add(Station.setFromFireStore(element));
          }
          return _getLocation(context);
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }

  Widget _getLocation(BuildContext context) {
    _userLocation.setChecker(_stations);
    return StreamBuilder<UserLocation>(
      stream: LocationService().locationStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _userLocation.longitude = snapshot.data!.longitude;
          _userLocation.latitude = snapshot.data!.latitude;
          _userLocation.checkPosition(_stations);
          _stations.sort((a, b) => a.distance.compareTo(b.distance));
          return _mainBody(context);
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }

  Widget _mainBody(BuildContext context) {
    List<Widget> _pageOptions = <Widget>[
      HomePage(_stations, _userLocation),
      ArrivePage(_stations, _userLocation),
      const ProfilePage()
    ];

    List<String> _pageTitle = <String>[
      'Inicio',
      'Arribo',
      'Perfil',
    ];

    return GestureDetector(
        child: Scaffold(
          backgroundColor: const Color(0xffe4e4e3),
          appBar: AppBar(
            backgroundColor: const Color(0xffe9540d),
            title: Text(_pageTitle.elementAt(_selectedPage)),
          ),
          body: Center(
              child: _pageOptions.elementAt(_selectedPage)
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPage,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Inicio'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.directions_subway_outlined),
                  label: 'Arribo'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined), label: 'Perfil'),
            ],
            onTap: (index) => setState(() {
              _selectedPage = index;
            }),
            selectedFontSize: 20,
            backgroundColor: const Color(0xffe4e4e3),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            selectedIconTheme: const IconThemeData(color: Color(0xffff8641), size: 40),
            selectedItemColor: const Color(0xffff8641),
          ),
        ),
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity! < 0) {
            setState(() {
              _selectedPage++;
              if (_selectedPage >= _pageOptions.length) _selectedPage = 0;
            });
          } else if (dragEndDetails.primaryVelocity! > 0) {
            setState(() {
              _selectedPage--;
              if (_selectedPage < 0) _selectedPage = _pageOptions.length - 1;
            });
          }
        });
  }
}
