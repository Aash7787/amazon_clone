import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/select_text_w.dart';
import 'package:flutter_amazon_clone/features/address/widgets/address_app_bar.dart';
import 'package:flutter_amazon_clone/features/address/widgets/address_text_form_field.dart';
import 'package:pay/pay.dart';

import '../payment_configurations/payment_configurations.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  static const routeName = 'address/Screen/route';

  @override
  Widget build(BuildContext context) {
    const address = 'context.watch<UserAuthProvider>().user.address';
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
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
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
          const Expanded(
            flex: 20,
            child: AddressTextFormField(),
          ),
          const Spacer(
            flex: 2,
          ),
          GooglePayButton(
            paymentConfiguration:
                PaymentConfiguration.fromJsonString(defaultGooglePay),
            paymentItems: const [],
          ),
          const Spacer(
            flex: 13,
          ),
        ],
      ),
    );
  }
}
