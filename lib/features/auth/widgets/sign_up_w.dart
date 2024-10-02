import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/btn_w.dart';
import 'package:flutter_amazon_clone/common/widgets/my_text_form_field_w.dart';
import 'package:flutter_amazon_clone/providers/user_auth_provider.dart';
import 'package:provider/provider.dart';

class SignUpW extends StatelessWidget {
  const SignUpW({super.key, this.height});

  static const _nameHint = 'Name';
  static const _emailHint = 'Email';
  static const _passwordHint = 'Password';

  static const _signUpBtnText = 'sign Up';

  final double? height;

  static const duration = 300;

  @override
  Widget build(BuildContext context) {
    final signUpFormKey = GlobalKey<FormState>();
    final userAuthProvider = context.watch<UserAuthProvider>();

    return AnimatedContainer(
      height: height,
      color: userAuthProvider.signUpColor,
      duration: const Duration(milliseconds: duration),
      child: Form(
        key: signUpFormKey,
        child: Column(
          children: [
            Expanded(
              child: MyTextFormFieldW(
                textEditingController: userAuthProvider.nameEditingController,
                hint: _nameHint,
              ),
            ),
            Expanded(
              child: MyTextFormFieldW(
                hint: _emailHint,
                textEditingController: userAuthProvider.emailEditingController,
              ),
            ),
            Expanded(
              child: MyTextFormFieldW(
                obscureText: true,
                hint: _passwordHint,
                textEditingController: userAuthProvider.passwordEditingController,
              ),
            ),
            Expanded(
              child: BtnW(
                fontSize: 23,
                btnText: _signUpBtnText,
                onTap: () {
                  if (signUpFormKey.currentState!.validate()) {
                    userAuthProvider.signUpUser(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
