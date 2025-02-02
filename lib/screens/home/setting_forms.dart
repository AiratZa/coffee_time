import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w8/models/user.dart';
import 'package:w8/services/database.dart';

import 'package:w8/shared/constants.dart';
import 'package:w8/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser>(context);

    return StreamBuilder<CustomUserData>(  
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
        if (snapshot.hasData) {

          CustomUserData userData = snapshot.data;
              return Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Update yout brew settings",
                style: TextStyle(
                  fontSize: 18.0,
                ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (value) => value.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) => setState(() => _currentName = value),
                ),
                SizedBox(height: 20.0,),
                //dropdown
                DropdownButtonFormField(
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _currentSugars = value),
                ),
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (value) => setState(() => _currentStrength = value.toInt()),
                ),
                //slider
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate())
                    {
                      print(_currentName);
                      print(_currentSugars);
                      print(_currentStrength);
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars, 
                        _currentName ?? userData.name, 
                        _currentStrength ?? userData.strength
                        );
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          );
        } else
        {

          return Loading();

        }
        
      }
    );
  }
}