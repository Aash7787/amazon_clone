import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/cached_network_image_w.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/account/model/order.dart';
import 'package:flutter_amazon_clone/features/admin/service/admin_service.dart';
import 'package:flutter_amazon_clone/features/order_details/screen/order_detail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminService _adminService = AdminService();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await _adminService.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: GridView.builder(
              itemCount: orders!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final orderData = orders![index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetailScreen.routeName,
                        arguments: orderData);
                  },
                  child: CachedNetworkImageW(
                    imageUrl: orderData.products[0].images[0],
                  ),
                );
              },
            ),
          );
  }
}
