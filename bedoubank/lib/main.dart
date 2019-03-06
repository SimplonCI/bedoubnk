import 'dart:convert';

import 'package:bedoubank/config/env.dart';
import 'package:bedoubank/transaction/envoie.dart';
import 'package:bedoubank/transaction/retrait.dart';
import 'package:bedoubank/transaction/solde.dart';
import 'package:bedoubank/transaction/success.dart';
import 'package:bedoubank/views/dashboard.dart';
import 'package:bedoubank/views/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import './auth/login.dart';
import './auth/inscription.dart';
import './auth/mot_de_passe_oublie.dart';

void main(){

  runApp(new MaterialApp(
    home: new MyApp(),
    debugShowCheckedModeBanner: false,
    routes : <String, WidgetBuilder>{

      '/login': (BuildContext context) => new LoginPage(),
      '/inscription': (BuildContext context) => new InscriptionPage(),
      '/forget': (BuildContext context) => new ForgetPage(),
      '/dashboard' : (BuildContext context) => new DashboardPage(),
      '/webview' : (BuildContext context) => new WebViewPage(),
      '/solde' : (BuildContext context) => new SoldePage(),
      '/envoie' : (BuildContext context) => new EnvoiePage(),
      '/retrait' : (BuildContext context) => new RetraitPage(),
      '/success' : (BuildContext context) => new SuccessPage(),
      '/aftersplash' : (BuildContext context) => new AfterSplash()

    }

  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String email = '';
  String iduser = '';
  bool logged = false;
  String deviseName = '';
  String deviseId = '';
  String url = Global().env.apiBaseUrl+'/checkLogin.php';
  String code = '';
  //  verfication des donnees sharepreferences

  _deviseInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviseName = androidInfo.model;
    deviseId = androidInfo.androidId;

    print('Running on ${androidInfo.model}');
    print('Devise id  is ${deviseId}');

  }

  _sharePreferencesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    iduser = prefs.getString('iduser');
    print('Email is ${email} and iduser is ${iduser}');
  }

  Future<bool> _checkIfUserIsAlreadyLogged() async {
    final response = await http.post(
      url,
      body: {
        'email' : this.email,
        'iduser' : this.iduser,
        'deviseName' : this.deviseName,
        'deviseId' : this.deviseId
      }
    );



    var datauser = json.decode(response.body);
    print("Response code is : ${datauser['code']}");


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);



    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text('Nous sommes heureux de vous revoir parmis nous',
          textAlign: TextAlign.center,
          style: new TextStyle(
//              fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,

          ),),
        image: Image.asset('assets/images/logo.png'),
        backgroundColor: Color(0xffe60028),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.white
    );

  }
}

class AfterSplash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);


    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: RaisedButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: () {

          Navigator.of(context).pushReplacementNamed('/login');
        },
        padding: EdgeInsets.all(12),
        color: Color(0xffe60028),
        child: Text('CONNEXION', style: TextStyle(color: Colors.white)),
      ),
    );


    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: RaisedButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/inscription');
        },
        padding: EdgeInsets.all(12),
        color: Color(0xffe60028),
        child: Text('CRÉER UN COMPTE', style: TextStyle(color: Colors.white)),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 24.0),
            ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: loginButton
            ),
            SizedBox(height: 10.0),
            ButtonTheme(
              minWidth: 200.0,
              height: 50.0,
              child: registerButton
            )
          ],
        ),
      ),
    );
  }
}


