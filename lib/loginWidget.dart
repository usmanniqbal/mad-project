import 'package:flutter/material.dart';
import 'package:flutterappclassproject/components/authProvider.dart';
import 'package:flutterappclassproject/components/customButton.dart';
import 'package:provider/provider.dart';

import 'baseStatelessWidget.dart';

class LoginWidget extends BaseStateLessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 45.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 47.0,
              child: CustomButton(
                imageUri: 'assets/google-logo.png',
                text: 'Continue with google',
                color: Colors.white,
                onPressed: authProvider.signInWithGoogle,
                borderRadius: 5.0,
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            SizedBox(
              height: 47.0,
              child: CustomButton(
                imageUri: 'assets/facebook-logo.png',
                text: 'Continue with facebook',
                color: Colors.blueAccent[700],
                onPressed: authProvider.signInWithFacebook,
                borderRadius: 5.0,
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            SizedBox(
              height: 47.0,
              child: CustomButton(
                imageUri: 'assets/email-logo.png',
                text: 'Continue with Email',
                color: Colors.orange,
                onPressed: () {
                  _emailDialog(context, authProvider);
                },
                borderRadius: 5.0,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              'OR',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(
              height: 45.0,
              child: CustomButton(
                text: 'Sign in anonymous',
                color: Colors.grey[500],
                onPressed: authProvider.signInAnonymously,
                borderRadius: 5.0,
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _emailDialog(
      BuildContext context, AuthProvider authProvider) async {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter your email'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Login'),
              onPressed: () async {
                if (await authProvider.signInWithEmail(
                    emailController.text, passwordController.text)) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
