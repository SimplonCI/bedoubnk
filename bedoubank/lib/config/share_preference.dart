import 'package:shared_preferences/shared_preferences.dart';


class StockagePreferences {

  saveUser(int id,String email,bool logged) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged', logged);
    prefs.setInt('iduser', id);
    prefs.setString('email', email);
  }

  userPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = {
      'logged': prefs.getBool('logged'),
      'iduser': prefs.getInt('iduser'),
      'email' : prefs.getString('email')
    };
  }

  _deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('logged');
    prefs.remove('iduser');
    prefs.getString('email');
  }
}