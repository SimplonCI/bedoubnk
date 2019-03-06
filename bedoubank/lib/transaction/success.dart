import 'package:bedoubank/models/Retrait.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
//        child: Image.asset('assets/images/logo.png'),
        child: new Image(image: new AssetImage("assets/images/checko2.gif")),
      ),
    );


    final successButton = Padding(

      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: RaisedButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: () {
            Navigator.popAndPushNamed(context, '/dasboard');
        },
        padding: EdgeInsets.all(12),
        color: Color(0xffe60028),
        child: Text('Retour', style: TextStyle(color: Colors.white)),
      ),
    );

    final messageLabel = FlatButton(
      child: Text(
        'Transfert effectue avec success',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {

      },
    );

    return Scaffold(
      appBar: AppBar(
        title: new Text('TRANSFERT TERMINÉ'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 25.0),
            messageLabel,
            SizedBox(height: 8.0),

            ButtonTheme(
                minWidth: 200.0,
                height: 60.0,
                child: successButton
            ),

          ],
        ),
      )
    );
  }
}
