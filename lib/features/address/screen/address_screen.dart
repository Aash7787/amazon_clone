import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/select_text_w.dart';
import 'package:flutter_amazon_clone/features/address/widgets/address_app_bar.dart';
import 'package:flutter_amazon_clone/features/address/widgets/address_text_form_field.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  static const routeName = 'address/Screen/route';

  @override
  Widget build(BuildContext context) {
    final Future<PaymentConfiguration> googlePayConfigFuture =
        PaymentConfiguration.fromAsset('gpay.json');
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
            child: AddressTextFormField(),
          ),
          FutureBuilder<PaymentConfiguration>(
              future: googlePayConfigFuture,
              builder: (context, snapshot) => snapshot.hasData
                  ? GooglePayButton(
                      paymentConfiguration: snapshot.data!,
                      paymentItems: const [],
                      type: GooglePayButtonType.buy,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: (result) => Text(result.toString()),
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
