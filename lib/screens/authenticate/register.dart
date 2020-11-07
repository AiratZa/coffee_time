import 'package:flutter/material.dart';
import 'package:w8/services/auth.dart';
import 'package:w8/shared/constants.dart';
import 'package:w8/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;


    //text field states

  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up to CoffeeTime"),
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
                decoration: textInputDecoration.copyWith(hintText: 'E-mail',),
                validator: (value) => value.isEmpty ? 'Enter an e-mail' : null,
                onChanged: (value){
                  setState(()=> email = value);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password',),
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
                    setState(() => loading = true);
                    print(email);
                    print(password);
                    print('hey');
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    print('hey2');
                    if(result == null){
                      setState(() {
                      loading = false;
                      error = 'Maybe this email is already used by somebody or it\'s just not valid';
                      });
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