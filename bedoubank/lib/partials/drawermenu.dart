import 'package:flutter/material.dart';

class DraweMenu extends StatefulWidget {
  @override
  _DraweMenuState createState() => _DraweMenuState();
}

class _DraweMenuState extends State<DraweMenu> {
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
                  new Text('Nguyen Duc Hoang',
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),),
                  new Text('Software developer',
                    style:new TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            decoration: new BoxDecoration(
                color: Colors.blue
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.photo_album),
            title: new Text('Photos'),
            onTap: () {
              setState((){
                this.title = 'This is Photos page';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.notifications),
            title: new Text('Notifications'),
            onTap: () {
              setState((){
                this.title = 'This is Notifications page';
              });
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.settings),
            title: new Text('Settings'),
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
    return Container();
  }
}
