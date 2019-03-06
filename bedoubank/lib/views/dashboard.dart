import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './acceuil.dart' as acceuil;
import './historiques.dart' as historique;
import './parametre.dart' as parametre;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  TabController tabController;


  bool logged;
  String email = '';
  String userId = '';

  _getSharePreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logged = prefs.getBool('logged');
      email = prefs.getString('email');
      userId = prefs.getString('iduser');
    });

  }

  @override
  void initState(){
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
    _getSharePreference();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  var title = '';
  Drawer _buildDrawer(context) {
    return new Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new DrawerHeader(
            child: new Container(

              child: new Column(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset(
                    'assets/images/user.png',
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                  new Text('Josue TCHIRKTEMA',
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),),
                  new Text('tchirktemajosue@gmail.com',
                    style:new TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            decoration: new BoxDecoration(
                color: Color.fromRGBO(58, 66, 86, 1.0)
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.photo_album),
            title: new Text('MON SOLDE',),
            onTap: () {
              setState((){
                this.title = 'This is Photos page';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.notifications),
            title: new Text('TRANSCATIONS'),
            onTap: () {
              setState((){
                this.title = 'This is Notifications page';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.notifications),
            title: new Text('MES DOCUMENTS'),
            onTap: () {
              setState((){
                this.title = 'This is Notifications page';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.settings),
            title: new Text('PARAMETRES'),
            onTap: () {
              setState((){
                this.title = 'This is Notifications page';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.power_settings_new),
            title: new Text('DECONNEXION'),
            onTap: () {
              setState((){
                this.title = 'This is Settings page';
              });
              Navigator.pop(context);
            },
          ),

          new Divider(
            color: Colors.black45,
            indent: 16.0,
          ),
          new ListTile(
            title: new Text('About us'),
            onTap: () {
              setState((){
                this.title = 'This is About page';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            title: new Text('Privacy'),
            onTap: () {
              setState((){
                this.title = 'This is Privacy page';
              });
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(

        child: new Material(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: new TabBar(

              controller: tabController,
              indicatorColor: Colors.white,

              tabs: <Widget>[
                new Tab(

                  icon: new Icon(
                    Icons.home,

                  ),



                ),
                new Tab(
                  icon: new Icon(
                    Icons.compare_arrows,

                  ),

                ),
                new Tab(
                  icon: new Icon(
                    Icons.history,

                  ),

                ),

              ]
          ),
        )
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text('Dashboard'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.power_settings_new),

          onPressed: () {

          },
        ),

      ],
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
//      body: makeBody,
      bottomNavigationBar: makeBottom,
      drawer: _buildDrawer(context),
      body: new TabBarView(
          controller: tabController,
          children: <Widget>[
            new acceuil.AcceuilPage(),
            new parametre.ParametrePage(),
            new historique.HistoriquePage(),
          ]
      ),
    );
  }
}
