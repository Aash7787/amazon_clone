import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter_amazon_clone/features/auth/models/user.dart';

enum Auth { signIn, singUp }

class UserAuthProvider extends ChangeNotifier {
  void setUser(String users) {
    _user = User.fromJson(users);
    log('${user.token} response');
    notifyListeners();
  }

  void setUserFromModel(User user){
    _user = user;
    notifyListeners();
  }

  User _user = User(
      id: 'No id found',
      name: '',
      password: '',
      address: '',
      type: '',
      cart: [],
      token: '',
      email: '');

  User get user => _user;

  Auth _auth = Auth.singUp;

  Auth get auth => _auth;

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  final AuthService authService = AuthService();

  Color _signUpColor = Colors.white;
  Color _signInColor = GlobalVariables.greyBackgroundCOlor;

  Color get signInColor => _signInColor;
  Color get signUpColor => _signUpColor;

  void isSignUpColor() {
    if (_auth == Auth.singUp) {
      _signUpColor = Colors.white;
      _signInColor = GlobalVariables.greyBackgroundCOlor;
      passwordEditingController.clear();
      notifyListeners();
    } else {
      _signUpColor = GlobalVariables.greyBackgroundCOlor;
      _signInColor = Colors.white;
      passwordEditingController.clear();

      notifyListeners();
    }

    notifyListeners();
  }

  void toggleAuth() {
    _auth = _auth == Auth.signIn ? Auth.singUp : Auth.signIn;
    isSignUpColor();
    notifyListeners();
  }

  void signUpUser(BuildContext context) {
    authService.signUpUser(
        name: nameEditingController.text,
        email: emailEditingController.text,
        password: passwordEditingController.text,
        context: context);
  }

  void signInUser(BuildContext context) {
    authService.signInUser(
        email: emailEditingController.text,
        password: passwordEditingController.text,
        context: context);
  }

  Future<void> getUserDate(BuildContext context) async {
    return authService.getUserData(context);
  }

  @override
  void dispose() {
    super.dispose();
    nameEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
  }
}
