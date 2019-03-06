import 'dart:convert';

import 'package:bedoubank/auth/login.dart';
import 'package:bedoubank/config/env.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';




class InscriptionPage extends StatefulWidget {
  static String tag = 'inscription-page';
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {

  String url = Global().env.apiBaseUrl+'api/inscription.php';
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateNom = false;
  bool _validatePrenom = false;
  bool _validateTelephone = false;
  bool validateForm = false;

  String deviseName = '';
  String deviseId = '';


  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nomController = new TextEditingController();
  TextEditingController prenomController = new TextEditingController();
  TextEditingController telephoneController = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    _deviseInfo() async {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviseName = androidInfo.model;
      deviseId = androidInfo.androidId;

      print('Running on ${androidInfo.model}');
      print('Devise id  is ${deviseId}');

    }


    //  Affichage des messages en popup
    Future<void> _messagePopup(int code ,String titre) async {
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
                  if(code == 1){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }else{
                    Navigator.pop(context);
                  }

                },
              ),
            ],
          );
        },
      );
    }


    //fonction d'inscription permettant d'inserer l'utilisateur dans la base de donnee

    Future<void> _inscription() async{
      final response = await http.post(
          url,
          body: {
            'email' : emailController.text,
            'nom'   : nomController.text,
            'prenom': prenomController.text,
            'password': passwordController.text,
            'telephone' : telephoneController.text,
            'deviseId' : deviseId,
            'deviseName': deviseName
          }
      );

      var datauser = json.decode(response.body);
      print(datauser['code']);

      //Verification si l'inscription c'est bien faite
      if(datauser['code'] == 0){
          _messagePopup(datauser['code'],datauser['errors'][0]);
      }

      if(datauser['code'] == 1){
        _messagePopup(datauser['code'],datauser['message']);
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

    final nom = TextFormField(
      controller: nomController,
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
        labelText: 'Nom de famille',
        labelStyle: TextStyle(
            color: Colors.black54
        ),
        errorText: _validateNom ? 'Le Nom de famille ne peut pas être vide' : null,

      ),
    );

    final prenom = TextFormField(
      controller: prenomController,
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
        labelText: 'Prenom(s)',
        labelStyle: TextStyle(
            color: Colors.black54
        ),
        errorText: _validatePrenom ? 'Le prenom ne peut pas être vide' : null,

      ),
    );


    final telephone = TextFormField(
      controller: telephoneController,
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
        labelText: 'Numéro de téléphone',
        labelStyle: TextStyle(
            color: Colors.black54
        ),
        errorText: _validateTelephone ? 'Le numéro de téléphone ne peut pas être vide' : null,

      ),
    );

    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
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
        errorText: _validateEmail ? 'Le champ email est invalide' : null,

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

    final inscriptionButton = Padding(

      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: RaisedButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: () {
          _deviseInfo();
          bool isValidEmail = EmailValidator.validate(emailController.text);
          setState(() {

            if(telephoneController.text.isEmpty){
              _validateTelephone = true;
            }else{
              validateForm = true;

            }

            if(nomController.text.isEmpty){
              _validateNom = true;


            }else{
              validateForm = true;

            }

            if(prenomController.text.isEmpty){
              _validatePrenom = true;

            }else{
              validateForm = true;
            }

            if(emailController.text.isEmpty){
              _validateEmail = true;

            }else{
              validateForm = true;
            }



            if(passwordController.text.isEmpty){
              _validatePassword = true;
            }else{
              validateForm = true;
            }

            if(isValidEmail == false){
              print('-=====================');
              _validateEmail = true;
              validateForm = false;
            }else{
              validateForm = true;
              print('-===================== ${_validateEmail}');
            }
//            telephoneController.text.isEmpty ? _validateTelephone = true : _validateTelephone = false;
//            nomController.text.isEmpty ? _validateNom = true : _validateNom = false;
//            prenomController.text.isEmpty ? _validatePrenom= true : _validatePrenom= false;
//            emailController.text.isEmpty ? _validateEmail = true : _validateEmail = false;
//            passwordController.text.isEmpty ? _validatePassword = true : _validatePassword = false;
          });

          if(validateForm == true){
//            print('formulaire ok');
            _inscription();
          }


        },
        padding: EdgeInsets.all(12),
        color: Color(0xffe60028),
        child: Text('INSCRIPTION', style: TextStyle(color: Colors.white)),
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
            SizedBox(height: 8.0),
            nom,
            SizedBox(height: 8.0),
            prenom,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 10.0),
            telephone,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            ButtonTheme(
                minWidth: 200.0,
                height: 60.0,
                child: inscriptionButton
            ),

          ],
        ),
      ),
    );
  }
}
