import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nobetciEczane/filter.dart';
import 'package:nobetciEczane/google_maps.dart';
import 'package:nobetciEczane/listing.dart';
import 'globals.dart' as globals;

@immutable
class GoogleMapsSinglePage extends StatefulWidget {
  @override
  State<GoogleMapsSinglePage> createState() => GoogleMapsSinglePageState();
}

class GoogleMapsSinglePageState extends State<GoogleMapsSinglePage> {
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _initPos = CameraPosition(
    target: LatLng(38.4570895, 37.2712243),
    zoom: 14,
  );

  @override
  void initState() {
    print("GMap Single Page Started");
    print("Selected Pharmacy : " + globals.selectedPharmacy.toString());
    _initPos = CameraPosition(
      target: globals.selectedPharmacy.position,
      zoom: 16,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initPos,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   controller.animateCamera(CameraUpdate.newLatLngBounds(
              //       LatLngBounds(
              //           southwest: globals.selectedPharmacy.position,
              //           northeast: globals.selectedPharmacy.position),
              //       50));
              // });
            },
            markers: Set.from(globals.pharmacyMarkers),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 250, height: 50),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    child: Text('Tüm Nöbetçi Eczaneler'),
                    onPressed: () {
                      goToAllPharmacy();
                    }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 250, height: 50),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  child: Text(
                    'Filtrele',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    goToFilter();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> goToFilter() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FilterPage()),
    );
  }

  Future<void> goToPharmacyList() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Listing()),
    );
  }

  Future<void> goToAllPharmacy() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GoogleMapsPage()),
    );
  }
}
