import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.asset('assets/images/logo.png'),
    ),
  );

  final loginButton = Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
      ),
      onPressed:(){

      },
      padding: EdgeInsets.all(12),
      color: new Color(0xFFc30044),
      child: Text('Je me connecte', style: TextStyle(color: Colors.white)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Container(
      margin: EdgeInsets.only(top: 70.0),
      child: new Center(

        child: ListView(
          padding: EdgeInsets.only(left: 24.0,right: 24.0),

          children: <Widget>[
            logo,
            SizedBox(height: 20.0),
            loginButton
          ],
        ),
      ),
    );
  }
}
