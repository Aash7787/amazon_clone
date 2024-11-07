import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/select_text_w.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/address/service/address_service.dart';
import 'package:flutter_amazon_clone/features/address/widgets/address_app_bar.dart';
import 'package:flutter_amazon_clone/features/address/widgets/address_text_form_field.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../auth/providers/user_auth_provider.dart';
import '../payment_configurations/payment_configurations.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.totalAmount});

  static const routeName = 'address/Screen/route';

  final String totalAmount;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late final Future<PaymentConfiguration> _googleConfiguration;

  List<PaymentItem> payment = [];

  String addressToBeUsed = '';

  final _addressFormKey = GlobalKey<FormState>();

  // Controllers for the address fields
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _googleConfiguration = PaymentConfiguration.fromAsset('gpay.json');
    payment.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  final AddressService addressService = AddressService();

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserAuthProvider>().user.address;
    log(address);
    return Scaffold(
      appBar: const AddressAppBar(),
      body: Column(
        children: [
          if (address.isNotEmpty)
            Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: SelectTextW(
                      address,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          Expanded(
            flex: 20,
            child: AddressTextFormField(
              formKey: _addressFormKey,
              cityController: _cityController,
              flatBuildingController: _flatBuildingController,
              pinCodeController: _pinCodeController,
              areaController: _areaController,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          GooglePayButton(
            paymentConfiguration:
                PaymentConfiguration.fromJsonString(defaultGooglePay),
            onPaymentResult: (result) {
              log('${context.read<UserAuthProvider>().user.address} address');

              log('onPayment is pressed $result');
              _onGooglePayResult(result);
            },
            onPressed: () => payPressed(address),
            loadingIndicator: const CupertinoActivityIndicator(),
            paymentItems: payment,
          ),
          const Spacer(
            flex: 6,
          ),
          FutureBuilder(
            future: _googleConfiguration,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              log('${snapshot.data}');
              return snapshot.hasData
                  ? GooglePayButton(
                      onPressed: () => payPressed(address),
                      paymentConfiguration: snapshot.data,
                      onPaymentResult: _onGooglePayResult,
                      loadingIndicator: const CupertinoActivityIndicator(),
                      paymentItems: payment,
                    )
                  : const SizedBox();
            },
          ),
          const Spacer(
            flex: 6,
          ),
        ],
      ),
    );
  }

  void _onGooglePayResult(Map<String, dynamic> result) {
    if (context.read<UserAuthProvider>().user.address.isEmpty) {
      log('function is called');
      addressService.safeUserAddress(
          context: context, address: addressToBeUsed);
      addressService.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(
          widget.totalAmount,
        ),
      );
    } else {
      addressService.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(
          widget.totalAmount,
        ),
      );
    }
  }

  void payPressed(String addressFromProvider) {
    bool isAnyFieldUsed = _flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pinCodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;

    if (isAnyFieldUsed) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text} - ${_pinCodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }


}
