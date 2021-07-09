import 'dart:async';
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'google_maps.dart';
import 'globals.dart' as globals;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nöbetçi Eczane',
      home: NobetciEczane(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class NobetciEczane extends StatefulWidget {
  @override
  State<NobetciEczane> createState() => NobetciEczaneState();
}

class NobetciEczaneState extends State<NobetciEczane> {
  String baseUrl = "http://163.172.168.20/eczane-api.json";

  void getIl() async {
    final response = await http.get(baseUrl);
    var listData = jsonDecode(utf8.decode(response.bodyBytes));
    setState(() {
      globals.dataCities = listData['data'];
    });
    print("Data Il : $listData");
    getIlce("22");
  }

  void getIlce(String value) async {
    //var iller = jsonDecode(_valIl);
    var ilID = value;
    print(ilID);
    for (var il in globals.dataCities) {
      if (il['CityID'] == ilID) {
        var area = il['area'];
        print("Data City : $area");
        setState(() {
          globals.dataTowns = area;
        });
        break;
      }
    }
    print(globals.dataTowns);
  }

  @override
  void initState() {
    getIl();
    print("APP STARTED");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: new TextButton(
                  onPressed: () {
                    goToMaps();
                  },
                  child: new Image(
                      image: AssetImage('assets/logo.png'), fit: BoxFit.fill)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> goToMaps() async {
    globals.pharmacyMarkers = [];

    for (var town in globals.dataTowns) {
      //print("\n town : " + town["areaName"]);
      if (town["areaName"] == globals.selectedTown) {
        for (var pharmacy in town["pharmacy"]) {
          globals.pharmacyMarkers.add(new Marker(
              markerId: MarkerId("marker"),
              position: LatLng(double.parse(pharmacy['maps'].split(",")[0]),
                  double.parse(pharmacy['maps'].split(",")[1])),
              infoWindow: InfoWindow(
                title: pharmacy['name'],
                snippet: pharmacy['address'] + "\n\n" + pharmacy['phone'],
              )));
        }
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GoogleMapsPage()),
    );
  }
}
