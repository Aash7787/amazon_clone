import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:flutter_amazon_clone/features/auth/widgets/sign_up_w.dart';
import 'package:flutter_amazon_clone/features/auth/widgets/radio_signs.dart';
import 'package:flutter_amazon_clone/features/auth/widgets/sign_in_w.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const pageName = 'auth_screen';

  static const _welcomeT = 'Welcome';

  static const _signUpRadio = 'Create Account.';
  static const _signInRadio = 'Sign-in.';

  static const _welcomeTextSize = 26.0;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<UserAuthProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                _welcomeT,
                style: TextStyle(
                  fontSize: _welcomeTextSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            RadioSigns(
              color: authProvider.signUpColor,
              radio: Radio(
                value: Auth.singUp,
                groupValue: authProvider.auth,
                onChanged: (value) {
                  authProvider.toggleAuth();
                },
              ),
              radioText: _signUpRadio,
            ),
            SignUpW(
              height: authProvider.auth == Auth.singUp ? 300 : 0.0,
            ),
            RadioSigns(
              color: authProvider.signInColor,
              radioText: _signInRadio,
              radio: Radio(
                value: Auth.signIn,
                groupValue: authProvider.auth,
                onChanged: (value) {
                  authProvider.toggleAuth();
                },
              ),
            ),
            SignInW(
              height: authProvider.auth == Auth.signIn ? 230 : 0.0,
            ),
          ],
        ),
      ),
    );
  }
}
