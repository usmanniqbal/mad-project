import 'package:flutter/material.dart';
import 'package:flutterappclassproject/apiPath.dart';
import 'package:flutterappclassproject/baseStatelessWidget.dart';
import 'package:flutterappclassproject/components/authProvider.dart';
import 'package:flutterappclassproject/components/firestoreDatabase.dart';
import 'package:flutterappclassproject/models/user.dart';
import 'package:provider/provider.dart';

class HomeWidget extends BaseStateLessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    FirestoreDatabase firestoreDatabase = Provider.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await firestoreDatabase.addData(
              path: ApiPath.user(authProvider.user.uid),
              data: User(
                      uid: authProvider.user.uid,
                      username: authProvider.user.displayName)
                  .toMap());
        },
        elevation: 5.0,
        splashColor: Colors.blueGrey,
      ),
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
