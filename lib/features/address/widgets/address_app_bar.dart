import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AddressAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddressAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables
            .appBarGradient, // Use the gradient from GlobalVariables
      ),
    ));
  }
}
