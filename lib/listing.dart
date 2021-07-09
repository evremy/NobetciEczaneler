import 'package:nobetciEczane/filter.dart';
import 'google_maps.dart';

import 'globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/material/colors.dart';
import 'package:nobetciEczane/widgets/eczane_card.dart';

class Listing extends StatefulWidget {
  const Listing({Key key}) : super(key: key);

  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Eczaneler Listesi",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int i = 0; i < globals.dataTowns.length; i++)
              if (globals.dataTowns[i]["areaName"] == globals.selectedTown)
                for (int j = 0;
                    j < globals.dataTowns[i]["pharmacy"].length;
                    j++)
                  new EczaneCard(
                    eczaneAdi: globals.dataTowns[i]["pharmacy"][j]["name"],
                    adres: globals.dataTowns[i]["pharmacy"][j]["address"],
                    tel: globals.dataTowns[i]["pharmacy"][j]["phone"],
                    konum: globals.dataTowns[i]["pharmacy"][j]["maps"],
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleMapsPage()),
                );
              },
            ),
            title: new Text(
              'Anasayfa',
              style: TextStyle(fontSize: 15),
            ),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.filter_list_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilterPage()),
                );
              },
            ),
            title: new Text(
              'Filtrele',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
