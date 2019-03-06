import 'dart:convert';

import 'package:bedoubank/auth/mot_de_passe_oublie.dart';
import 'package:bedoubank/config/env.dart';
import 'package:bedoubank/views/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _validateUsername = false;
  bool _validatePassword = false;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    String url = Global().env.apiBaseUrl+'api/connexion.php';

    //  Affichage des messages en popup
    Future<void> _messagePopup(String titre) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titre),
            actions: <Widget>[
              FlatButton(
                child: Text('ok'),
                onPressed: () {

                    Navigator.pop(context);

                },
              ),
            ],
          );
        },
      );
    }


//    fonction de connexion d'un utlisateur

    Future<List> _login() async{
      final response = await http.post(
          url,
          body: {
            'username' : usernameController.text,
            'password': passwordController.text
          }
      );

      var datauser = json.decode(response.body);
//      print(datauser['code']);

      //si on a pas trouve d'utilisation
      if(datauser['code']==0){
//        Navigator.of(context).pushReplacementNamed('/dashboard');
        _messagePopup(datauser['message']);
      } else{
        var userCurrent = datauser['user'][0];
        print(userCurrent);

        // sauvegarde des donnees de l'utilisateur dans le share preference
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('logged', true);
        prefs.setString('iduser',userCurrent['id'] );
        prefs.setString('email', userCurrent['email']);
        prefs.setString('sexe', userCurrent['sexe']);
        prefs.setString('agent', userCurrent['agent']);
        prefs.setString('dateNaissance', userCurrent['dateNaissance']);
        prefs.setString('nom', userCurrent['nom']);
        prefs.setString('prenom', userCurrent['prenom']);
        prefs.setString('password', userCurrent['password']);
        prefs.setString('telephone', userCurrent['telephone']);
        prefs.setString('agent', userCurrent['agent']);

        // redirection de l'utilisateur
//        MaterialPageRoute(
//          builder: (context) => DashboardPage()
//        );

        Navigator.of(context).pushReplacementNamed('/webview');
      }
    }

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );


    final username = TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        fillColor: Color(0xffe60028),
        focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(
                color: Colors.black54
            )
        ),
        border: OutlineInputBorder(),
        labelText: 'Adresse email ou Telephone',
        labelStyle: TextStyle(
          color: Colors.black54
        ),
        errorText: _validateUsername ? 'Le champ email est invalide' : null,

      ),
    );

    final password = TextField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          fillColor: Color(0xffe60028),
          focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(
                color: Colors.black54
            )
          ),
          border: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)
          ),
          labelText: 'Mot de passe',
          labelStyle: TextStyle(
              color: Colors.black54
          ),
          errorText: _validatePassword ? 'Le champ mot de passe ne pas etre vide' : null,
      ),
    );

    final loginButton = Padding(

      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: RaisedButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: () {
          setState(() {
            usernameController.text.isEmpty ? _validateUsername = true : _validateUsername = false;
            passwordController.text.isEmpty ? _validatePassword = true : _validatePassword = false;
          });

          _login();
        },
        padding: EdgeInsets.all(12),
        color: Color(0xffe60028),
        child: Text('CONNEXION', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Mot de passe oublié?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgetPage()),
        );
      },
    );



    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 25.0),
            username,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            ButtonTheme(
                minWidth: 200.0,
                height: 60.0,
                child: loginButton
            ),
            forgotLabel
          ],
        ),
      ),
    );
  }
}
