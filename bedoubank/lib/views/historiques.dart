import 'package:flutter/material.dart';
import '../models/historique.dart';

class Lesson {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;

  Lesson(
      {this.title, this.level, this.indicatorValue, this.price, this.content});
}

class HistoriquePage extends StatefulWidget {
  @override
  _HistoriquePageState createState() => _HistoriquePageState();
}



class _HistoriquePageState extends State<HistoriquePage> {

  List historiques;

  @override
  void initState() {
    historiques = getHistoriques();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    ListTile makeListTile(Historique historique) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

      title: Text(
        historique.libelle,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[

          Text(
            'Date : '+historique.dateValidation,
            style: TextStyle(
              color: Colors.white
            ),
          )
        ],
      ),


    );

    Card makeCard(Historique historique) => Card(
      elevation: 3.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(historique),
      ),
    );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: historiques.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(historiques[index]);
        },
      ),
    );


    return Scaffold(
      body: makeBody,
    );
  }
}



List getHistoriques() {
  return [
    Historique(
        libelle: "Retrait 3000",
        emetteur: "Beginner",
        price: 20,
        recepteur: "agence de yopougon",
        dateValidation: '23/08/2019',
        indicatorValue: 0.33
    ),
    Historique(
        libelle: "Retrait 3000",
        emetteur: "Beginner",
        price: 20,
        recepteur: "agence de yopougon",
        dateValidation: '23/08/2019',
        indicatorValue: 0.33
    )
  ];
}
