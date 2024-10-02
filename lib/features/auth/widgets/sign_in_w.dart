import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/btn_w.dart';
import 'package:flutter_amazon_clone/common/widgets/my_text_form_field_w.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:provider/provider.dart';

class SignInW extends StatelessWidget {
  const SignInW({super.key, this.height});

  static const _emailHint = 'Email';
  static const _passwordHint = 'Password';

  static const _signUpBtnText = 'Login';

  final double? height;

  static const duration = 300;

  @override
  Widget build(BuildContext context) {
    final signInFormKey = GlobalKey<FormState>();

    final authProvider = context.watch<UserAuthProvider>();

    return AnimatedContainer(
      height: height,
      color: authProvider.signInColor,
      duration: const Duration(milliseconds: duration),
      child: Form(
        key: signInFormKey,
        child: Column(
          children: [
            Expanded(
              child: MyTextFormFieldW(
                hint: _emailHint,
                textEditingController: authProvider.emailEditingController,
              ),
            ),
            Expanded(
              child: MyTextFormFieldW(
                obscureText: true,
                hint: _passwordHint,
                textEditingController: authProvider.passwordEditingController,
              ),
            ),
            Expanded(
              child: BtnW(
                fontSize: 23,
                btnText: _signUpBtnText,
                onTap: () {
                  if (signInFormKey.currentState!.validate()) {
                    authProvider.signInUser(context);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
