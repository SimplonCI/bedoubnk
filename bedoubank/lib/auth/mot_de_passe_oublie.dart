import 'package:bedoubank/auth/login.dart';
import 'package:flutter/material.dart';

class ForgetPage extends StatefulWidget {
  static String tag = 'forget-page';
  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  bool _validateEmail = false;
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/logo.png'),
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



    final forgetButton = Padding(

      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: RaisedButton(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: () {
          setState(() {
            emailController.text.isEmpty ? _validateEmail = true : _validateEmail = false;
          });
//          Navigator.of(context).pushNamed(ForgetPage.tag);
        },
        padding: EdgeInsets.all(12),
        color: Color(0xffe60028),
        child: Text('RÉCUPÉRER MON MOT DE PASSE', style: TextStyle(color: Colors.white)),
      ),
    );

    final loginLabel = FlatButton(
      child: Text(
        'connexion',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
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
            email,
            SizedBox(height: 8.0),
            ButtonTheme(
                minWidth: 200.0,
                height: 60.0,
                child: forgetButton
            ),
            loginLabel
          ],
        ),
      ),
    );
  }
}
