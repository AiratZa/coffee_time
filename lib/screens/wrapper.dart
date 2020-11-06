import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w8/models/user.dart';
import 'package:w8/screens/authenticate/authenticate.dart';
import 'package:w8/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<CustomUser>(context);
    print(user);
    //return Home or Authenticate
    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}