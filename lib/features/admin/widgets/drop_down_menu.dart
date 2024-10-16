import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

var category = 'Mobiles';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButton(
        // focusColor: Colors.white,
        items: GlobalVariables.categoryImages
            .map(
              (e) => DropdownMenuItem(
                value: e['title'],
                child: Text(e['title']!),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(
            () {
              category = value!;
            },
          );
        },
        value: category,
        icon: const Icon(Icons.arrow_drop_down),
      ),
    );
  }
}
