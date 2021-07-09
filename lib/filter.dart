import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_maps.dart';
import 'globals.dart' as globals;

class FilterPage extends StatefulWidget {
  FilterPage();

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String _valCity, _valTown;
  bool _isSelected = false;

  void getIlce(String value) async {
    var ilID = value;
    //print(ilID);
    for (var il in globals.dataCities) {
      if (il['CityID'] == ilID) {
        var area = il['area'];
        //print("Data City : $area");
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
    print(globals.dataCities);
    print(globals.dataTowns);
    super.initState();
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtrele"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(
                    color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 0.80),
              ),
              child: DropdownButton(
                elevation: 8,
                style: TextStyle(color: Colors.black87, fontSize: 16),
                icon: Icon(Icons.arrow_drop_down_circle),
                iconDisabledColor: Colors.red,
                iconEnabledColor: Colors.red,
                isExpanded: true,
                hint: Text("Türkiye"),
                onChanged: (value) {
                  setState(() {});
                },
                items: [],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(
                    color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 0.80),
              ),
              child: DropdownButton(
                elevation: 8,
                style: TextStyle(color: Colors.black87, fontSize: 16),
                icon: Icon(Icons.arrow_drop_down_circle),
                iconEnabledColor: Colors.red,
                isExpanded: true,
                hint: Text("İl Seçiniz"),
                value: _valCity,
                items: globals.dataCities.map((item) {
                  return DropdownMenuItem(
                    child: Text(item['CityName']),
                    value: item['CityID'],
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valCity = value;
                    _valTown = null;
                  });
                  getIlce(value);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(
                    color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 0.80),
              ),
              child: DropdownButton(
                elevation: 8,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
                icon: Icon(Icons.arrow_drop_down_circle),
                iconDisabledColor: Colors.red,
                iconEnabledColor: Colors.red,
                isExpanded: true,
                hint: Text("İlçe Seçiniz"),
                value: _valTown,
                items: globals.dataTowns.map((item) {
                  return DropdownMenuItem(
                    child: Text(item['areaName']),
                    value: item['areaName'],
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valTown = value;
                    _isSelected = true;
                    globals.selectedTown = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 250, height: 50),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                child: Text(
                  'Eczaneleri Görüntüle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                onPressed: _isSelected
                    ? () {
                        setState(() {
                          _isSelected = false;
                        });
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => GoogleMapsPage()),
                        // );
                        goToMaps();
                      }
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
