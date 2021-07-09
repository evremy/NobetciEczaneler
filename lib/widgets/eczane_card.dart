import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nobetciEczane/google_maps_single.dart';
import 'package:url_launcher/url_launcher.dart';
import '../google_maps.dart';
import '../globals.dart' as globals;

class EczaneCard extends StatelessWidget {
  final String eczaneAdi;
  final String adres;
  final String tel;
  final String konum;
  const EczaneCard({Key key, this.eczaneAdi, this.adres, this.tel, this.konum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
          alignment: Alignment.center,
          child: Container(
            width: 400,
            height: 250,
            padding: new EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color(0xffd50000),
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Text(
                      this.eczaneAdi,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 20,
                            //height: 20,
                          ),
                          Text(
                            'ADRES:',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            height: 50,
                          ),
                          Expanded(
                            child: Text(
                              StringUtils.capitalize(this.adres),
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 20, bottom: 0, right: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'TEL:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 20, bottom: 0, right: 20),
                            child: Text(
                              this.tel,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0, left: 5, bottom: 0),
                        child: IconButton(
                          icon: Icon(Icons.phone, color: Colors.white),
                          onPressed: () {
                            _callPhone('tel://' + this.tel);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          left: 230,
                          bottom: 10,
                        ),
                        child: new FloatingActionButton(
                          onPressed: () {
                            print(this.konum);
                            globals.selectedPharmacy = new Marker(
                                markerId: MarkerId("marker"),
                                position: LatLng(
                                    double.parse(this.konum.split(",")[0]),
                                    double.parse(this.konum.split(",")[1])),
                                infoWindow: InfoWindow(
                                  title: this.eczaneAdi,
                                  snippet: this.adres + "\n\n" + this.tel,
                                ));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoogleMapsSinglePage()),
                            );
                          },
                          backgroundColor: Colors.white,
                          child: new Icon(
                            Icons.navigation_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    ]);
  }

  Future<void> _callPhone(String telNo) async {
    // arama yap
    if (await canLaunch(telNo)) {
      await launch(telNo);
    } else {
      throw 'Başlatılamadı: $telNo';
    }
  }
}
