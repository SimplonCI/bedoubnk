import 'package:bedoubank/transaction/envoie.dart';
import 'package:bedoubank/transaction/retrait.dart';
import 'package:bedoubank/transaction/solde.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcceuilPage extends StatefulWidget {
  @override
  _AcceuilPageState createState() => _AcceuilPageState();
}

class _AcceuilPageState extends State<AcceuilPage> {
  var agent ;

  Future<String> isAgence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      this.agent = prefs.getString('agent');
    });



  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAgence();
  }


  @override
  Widget build(BuildContext context) {





    final retrait = GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RetraitPage()),
        );
      },
      child: Card(
        color: Color(0xffd81235),
        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 15.0,
              child: Image.asset(
                'assets/images/solde.png',
                fit: BoxFit.fitWidth,
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 2.0),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('RETRAIT',

                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final retraitArgent = GestureDetector(
      onTap: (){

      },
      child: Card(
        color: Color(0xffd81235),
        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 15.0,
              child: Image.asset(
                'assets/images/solde.png',
                fit: BoxFit.fitWidth,
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 2.0),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('RETRAIT',

                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final solde = GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SoldePage()),
        );
      },
      child: Card(
        color: Color(0xffd81235),
        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 15.0,
              child: Image.asset(
                'assets/images/solde.png',
                fit: BoxFit.fitWidth,
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 2.0),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('MON SOLDE',

                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final transfert = GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EnvoiePage()),
        );
      },
      child: Card(
        color: Color(0xffd81235),
        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 15.0,
              child: Image.asset(
                'assets/images/transfert.png',
                fit: BoxFit.fitWidth,
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 2.0),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('TRANSFERT',

                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final envoie = GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EnvoiePage()),
        );
      },
      child: Card(
        color: Color(0xffd81235),
        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 15.0,
              child: Image.asset(
                'assets/images/transfert.png',
                fit: BoxFit.fitWidth,
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 2.0),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('ENVOIE',

                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final facture = GestureDetector(
      onTap: (){
        print('Factures');
      },
      child: Card(
        color: Color(0xffd81235),
        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 15.0,
              child: Image.asset(
                'assets/images/facture.png',
                fit: BoxFit.fitWidth,
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 2.0),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('FACTURES',

                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final agences = GestureDetector(
      onTap: (){
        print('agences');
      },
      child: Card(
        color: Color(0xffd81235),
        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 15.0,
              child: Image.asset(
                'assets/images/agence.png',
                fit: BoxFit.fitWidth,
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 2.0),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('NOS AGENCES',

                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


    if(this.agent == '0'){
      print('=========== ${this.agent} =========');
      return Scaffold(
        body: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 8.0 / 9.0,
            children:<Widget>[
              retraitArgent,
              envoie,
              facture,
              agences
            ] // Replace
        ),
      );
    }else{
      print('=========== ${this.agent} =========');
      return Scaffold(
        body: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 8.0 / 9.0,
            children:<Widget>[
              retrait,
              envoie,
              facture,
              agences
            ] // Replace
        ),
      );
    }
  }
}
