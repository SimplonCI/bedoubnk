import 'package:flutter/material.dart';

class SoldePage extends StatefulWidget {
  @override
  _SoldePageState createState() => _SoldePageState();
}

class _SoldePageState extends State<SoldePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text('SOLDE'),
      ),
    );
  }
}
