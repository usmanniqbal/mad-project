import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  FirebaseUser user;
  StreamSubscription userAuthSub;

  AuthProvider() {
    userAuthSub = FirebaseAuth.instance.onAuthStateChanged.listen((newUser) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $newUser');
      user = newUser;
      notifyListeners();
    }, onError: (e) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }

  @override
  void dispose() {
    if (userAuthSub != null) {
      userAuthSub.cancel();
      userAuthSub = null;
    }
    super.dispose();
  }

  bool get isAnonymous {
    assert(user != null);
    bool isAnonymousUser = true;
    for (UserInfo info in user.providerData) {
      if (info.providerId == "facebook.com" ||
          info.providerId == "google.com" ||
          info.providerId == "password") {
        isAnonymousUser = false;
        break;
      }
    }
    return isAnonymousUser;
  }

  bool get isAuthenticated {
    return user != null;
  }

  Future signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Future signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing google auth Token ',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'you Abortedthe sign in ',
      );
    }
  }

  Future signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    final result = await facebookLogin.logIn(['public_profile']);

    if (result.status == FacebookLoginStatus.loggedIn) {
      final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future<bool> _isEmailRegistered(String email) async {
    final providers =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email: email);

    bool result = false;
    for (var provider in providers) {
      if (provider == 'password') {
        result = true;
        break;
      }
    }

    return result;
  }

  Future<bool> signInWithEmail(String email, String password) async {
    AuthResult result;
    if (await _isEmailRegistered(email)) {
      result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } else {
      result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    }

    return result.user != null;
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
