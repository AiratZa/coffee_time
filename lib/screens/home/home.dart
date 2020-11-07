import 'package:flutter/material.dart';
import 'package:w8/models/brew.dart';
import 'package:w8/screens/home/setting_forms.dart';
import 'package:w8/services/auth.dart';

import 'package:w8/services/database.dart';
import 'package:provider/provider.dart';
import 'package:w8/screens/home/brew_list.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      }
      );
    }


    return StreamProvider<List<Brew>>.value(
        value: DatabaseService().brews,
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("CoffeeTime"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("LogOut"),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
          child: BrewList()
        ),
      ),
    );
  }
}