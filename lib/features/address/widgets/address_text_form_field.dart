import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/my_text_form_field_w.dart';

class AddressTextFormField extends StatefulWidget {
  const AddressTextFormField({super.key});

  @override
  State<AddressTextFormField> createState() => _AddressTextFormFieldState();
}

class _AddressTextFormFieldState extends State<AddressTextFormField> {
  late final TextEditingController _flatBuildingController;
  late final TextEditingController _areaController;
  late final TextEditingController _pinCodeController;
  late final TextEditingController _cityController;

  @override
  void initState() {
    super.initState();
    _flatBuildingController = TextEditingController();
    _areaController = TextEditingController();
    _pinCodeController = TextEditingController();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  final addressFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addressFormKey,
      child: Column(
        children: [
          Expanded(
            child: MyTextFormFieldW(
              textEditingController: _flatBuildingController,
              hint: 'Flat, Building, House no.',
            ),
          ),
          Expanded(
            child: MyTextFormFieldW(
              hint: 'Area, Street',
              textEditingController: _areaController,
            ),
          ),
          Expanded(
            child: MyTextFormFieldW(
              obscureText: true,
              hint: 'Pin code',
              textEditingController: _pinCodeController,
            ),
          ),
          Expanded(
            child: MyTextFormFieldW(
              obscureText: true,
              hint: 'Town / City',
              textEditingController: _cityController,
            ),
          ),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          const Spacer()
        ],
      ),
    );
  }
}
