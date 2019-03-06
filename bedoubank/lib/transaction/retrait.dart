import 'package:bedoubank/transaction/success.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:bedoubank/config/env.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class RetraitPage extends StatefulWidget {
  @override
  _RetraitPageState createState() => _RetraitPageState();
}

class _RetraitPageState extends State<RetraitPage> {

  bool _validateMontant = false;
  bool _validateBeneficiaire= false;
  bool _validatePassword = false;

  TextEditingController montantController = new TextEditingController();
  TextEditingController beneficiaireController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    String url = Global().env.apiBaseUrl+'/retrait.php';

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

    Future<void> _messageSuccessPopup(String titre) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('INFORMATION'),
            content: Text(
                titre
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ok'),
                onPressed: () {

                  Navigator.popAndPushNamed(context, '/dashboard');

                },
              ),
            ],
          );
        },
      );
    }


    //    fonction de retrait d'argent

    Future<List> _retrait() async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("Logged : ${prefs.getBool('logged')}");
      print("Email : ${prefs.getString('email')}");
      print("Password : ${prefs.getString('password')}");
      print("Iduser : ${prefs.getString('iduser')}");

      String email  = prefs.getString('email');
      String iduser = prefs.getString('iduser');
      String numeroEmetteur = prefs.getString('telephone');
      String password = passwordController.text;
      String numeroRecepteur = beneficiaireController.text;
      String montant = montantController.text;


      print(url);
      final response = await http.post(
          url,
          body: {
            'numeroClient' : numeroEmetteur,
            'password': password ,
            'numeroAgent': numeroRecepteur,
            'montant': montant,
            'email': email ,
            'id' :  iduser

          }
      );

      var datauser = json.decode(response.body);

      if(datauser['code']==0){
        print("============ ${datauser['code']} ========");
//        Navigator.of(context).pushReplacementNamed('/dashboard');
        _messagePopup(datauser['message']);
      } else{
        _messageSuccessPopup(datauser['message']);
      }

    }


    //confirmation de la popup

    Future<void> _confirmPopup(String title) async {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Confirmation'),
          content: Text(
            'Voullez vraiment effectuer un retrait  de ${title} du ${beneficiaireController.text}',
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Annuler'),
              onPressed: () => Navigator.pop(context, 'Annuler'),
            ),
            FlatButton(
              child: Text('Valider'),
              onPressed: () => Navigator.pop(context, 'Valider'),
//              onPressed: () {
//                  print('dedede');
////                _retrait(int.parse(this.montantController.text),this.beneficiaireController.text);
//              }
            ),
          ],
        ),
      ).then<String>((returnVal) {
        if (returnVal != null) {
          if(returnVal == 'Valider'){
            _retrait();
          }

          if(returnVal == 'Annuler'){
            _scaffoldKey.currentState..showSnackBar(
              SnackBar(
                content: Text('La transaction a été annuler'),
                action: SnackBarAction(label: 'OK', onPressed: () {}),
              ),
            );
          }

        }
      });

    }



    final montant = TextFormField(
      controller: montantController,
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        fillColor: Color(0xffe60028),
        focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(
                color: Colors.black54
            )
        ),
        border: OutlineInputBorder(),
        labelText: 'Montant a envoyer',
        labelStyle: TextStyle(
            color: Colors.black54
        ),
        errorText: _validateMontant ? 'Le champ montant est invalide' : null,

      ),
    );


    final beneficiaire = TextFormField(
      controller: beneficiaireController,
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        fillColor: Color(0xffe60028),
        focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(
                color: Colors.black54
            )
        ),
        border: OutlineInputBorder(),
        labelText: "Numero de compte du beneficiaire",
        labelStyle: TextStyle(
            color: Colors.black54
        ),
        errorText: _validateBeneficiaire ? 'Le numero du beneficiaire est invalide' : null,

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
        labelText: 'Votre mot de passe',
        labelStyle: TextStyle(
            color: Colors.black54
        ),
        errorText: _validatePassword ? 'Le champ mot de passe ne pas etre vide' : null,
      ),
    );



    final envoyerButton = Padding(

      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: RaisedButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: () {

//          setState(() {
//            montantController.text.isEmpty ? _validateMontant = true : _validateMontant = false;
//            passwordController.text.isEmpty ? _validatePassword = true : _validatePassword = false;
//          });
          _confirmPopup(this.montantController.text);

        },
        padding: EdgeInsets.all(12),
        color: Color(0xffe60028),
        child: Text('Envoyer de  argent', style: TextStyle(color: Colors.white)),
      ),
    );





    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("RETRAIT D'ARGENT"),
      ),
      body: Center(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Text(
                "Formulaire de retrait d'argent".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,

                ),
              ),
              SizedBox(height: 25.0),
              montant,
              SizedBox(height: 25.0),
              beneficiaire,
              SizedBox(height: 25.0),
              password,
              SizedBox(height: 25.0),
              envoyerButton
            ]
        ),
      ),
    );
  }
}
