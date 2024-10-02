import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/features/account/widgets/product_tile_w.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  static const _yourOrders = 'Your Orders';
  static const _yourOrdersFontSize = 24.0;

  static const _seeAll = 'See All';
  static const _seeAllFontSize = 20.0;

  static const _padding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(_padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                _yourOrders,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _yourOrdersFontSize,
                ),
              ),
              const Spacer(),
              InkWell(
                // onTap: ,
                child: Text(
                  _seeAll,
                  style: TextStyle(
                    color: GlobalVariables.selectedNavBarColor,
                    fontSize: _seeAllFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: _padding),
          child: SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  ProductTileW(image: orderList[index]),
              itemCount: orderList.length,
            ),
          ),
        )
      ],
    );
  }
}
