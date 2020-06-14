import 'package:flutter/material.dart';
import 'package:flutterappclassproject/baseStatelessWidget.dart';
import 'package:flutterappclassproject/components/authProvider.dart';
import 'package:provider/provider.dart';

class HomeWidget extends BaseStateLessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          /* IconButton(onPressed: (){},
            icon: Icon(Icons.search),
          ),*/
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            onPressed: authProvider.signOut,
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
