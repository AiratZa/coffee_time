import 'package:flutter/material.dart';
import 'package:w8/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

    //text field states

  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up to W8"),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign In"),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0) ,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                validator: (value) => value.isEmpty ? 'Enter an e-mail' : null,
                onChanged: (value){
                  setState(()=> email = value);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (value) => value.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (value){
                  setState(()=> password = value);
                }
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    print(email);
                    print(password);
                    print('hey');
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    print('hey2');
                    if(result == null){
                      setState(() => error = 'Please supply a valid email');
                    }
                    
                  }

                },
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        )
        ),
    );
  }
}