import 'package:flutter/material.dart';
import 'package:flutterappclassproject/homeWidget.dart';
import 'package:flutterappclassproject/loginWidget.dart';
import 'package:provider/provider.dart';
import 'baseStatelessWidget.dart';
import 'components/authProvider.dart';

class LandingWidget extends BaseStateLessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    if (authProvider.isAuthenticated) {
      return HomeWidget();
    } else {
      return LoginWidget();
    }
  }
}
