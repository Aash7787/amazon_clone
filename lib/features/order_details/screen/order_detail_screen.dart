import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/btn_w.dart';
import 'package:flutter_amazon_clone/common/widgets/cached_network_image_w.dart';
import 'package:flutter_amazon_clone/common/widgets/select_text_w.dart';
import 'package:flutter_amazon_clone/features/account/model/order.dart';
import 'package:flutter_amazon_clone/features/admin/service/admin_service.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/view_order_text_w.dart';

class OrderDetailScreen extends StatefulWidget {
  static const routeName = 'order/detail/screen';
  const OrderDetailScreen({super.key, required this.order});
  final Order order;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 1;
  final adminService = AdminService();

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserAuthProvider>().user;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ViewOrderTextW('View order details'),
              const SizedBox(height: 10),
              _buildOrderDetails(),
              const SizedBox(height: 10),
              const ViewOrderTextW('Purchase Details'),
              _buildPurchaseDetails(),
              const SizedBox(height: 10),
              const ViewOrderTextW('Tracking'),
              _buildStepper(user),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.black12),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: SelectTextW(
                      'Order Date : ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: SelectTextW('Order id : ${widget.order.id}'),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: FittedBox(
                    child: SelectTextW('Order Total : \$${widget.order.totalPrice}'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseDetails() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          for (var i = 0; i < widget.order.products.length; i++)
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImageW(
                      imageUrl: widget.order.products[i].images[0],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectTextW(widget.order.products[i].name),
                      const SizedBox(height: 10),
                      SelectTextW('Quantity: ${widget.order.quantity[i]}'),
                      const SizedBox(height: 10),
                      SelectTextW('Price: \$${widget.order.products[i].price}'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStepper(user) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stepper(
        currentStep: currentStep,
        onStepTapped: (step) {
          // Only let admins change steps manually for demonstration
          if (user.type == 'admin') setState(() => currentStep = step);
        },
        controlsBuilder: (context, details) {
          if (user.type == 'admin' && currentStep < 3) {
            return BtnW(
              btnText: 'Next Step',
              onTap: () => _changeOrderStatus(details.currentStep),
            );
          }
          return const SizedBox();
        },
        steps: [
          Step(
            title: const Text('Pending'),
            content: const Text('Order yet to be delivered.'),
            isActive: currentStep >= 0,
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Shipped'),
            content: const Text('Order has been shipped.'),
            isActive: currentStep >= 1,
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Out for Delivery'),
            content: const Text('Order is out for delivery.'),
            isActive: currentStep >= 2,
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Delivered'),
            content: const Text('Order has been delivered and signed by you.'),
            isActive: currentStep == 3,
            state: currentStep == 3 ? StepState.complete : StepState.indexed,
          ),
        ],
      ),
    );
  }

  void _changeOrderStatus(int step) {
    adminService.changesOrderStatus(
      context: context,
      status: step + 1,
      onSuccess: () {
        setState(() {
          currentStep = step + 1;
        });
      },
      order: widget.order,
    );
  }
}
