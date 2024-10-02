import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:provider/provider.dart';

class AddressBoxW extends StatelessWidget {
  const AddressBoxW({super.key});

  static const _color1 = Color.fromARGB(255, 114, 225, 221);
  static const _color2 = Color.fromARGB(255, 162, 236, 233);
  static const _iconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserAuthProvider>();

    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_color1, _color2],
          stops: [0.5, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: _iconSize,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                'Devilry to ${user.user.name.toUpperCase()} - ${user.user.address}',
                style: const TextStyle(fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.arrow_drop_down,
              ),
            )
          ],
        ),
      ),
    );
  }
}
