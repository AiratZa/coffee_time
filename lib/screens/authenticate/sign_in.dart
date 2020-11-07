import 'package:flutter/material.dart';
import 'package:w8/services/auth.dart';
import 'package:w8/shared/constants.dart';
import 'package:w8/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  bool loading = false;
  
  //text field states

  String email = '';
  String password = '';
  String error = '';



  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to CoffeeTime"),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
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
                validator: (value) => value.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (value){
                  setState(()=> password = value);
                }
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    print(email);
                    print(password);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        loading = false;
                        error = 'Please supply valid credentials';
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


