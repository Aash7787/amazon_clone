import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/my_text_form_field_w.dart';

class AddressTextFormField extends StatelessWidget {
  const AddressTextFormField(
      {super.key,
      required this.flatBuildingController,
      required this.areaController,
      required this.pinCodeController,
      required this.cityController,
      required this.formKey});

  final TextEditingController flatBuildingController;
  final TextEditingController areaController;
  final TextEditingController pinCodeController;
  final TextEditingController cityController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Expanded(
            child: MyTextFormFieldW(
              textEditingController: flatBuildingController,
              hint: 'Flat, Building, House no.',
            ),
          ),
          Expanded(
            child: MyTextFormFieldW(
              hint: 'Area, Street',
              textEditingController: areaController,
            ),
          ),
          Expanded(
            child: MyTextFormFieldW(
              // obscureText: true,
              hint: 'Pin code',
              textEditingController: pinCodeController,
            ),
          ),
          Expanded(
            child: MyTextFormFieldW(
              hint: 'Town / City',
              textEditingController: cityController,
            ),
          ),
        ],
      ),
    );
  }
}
