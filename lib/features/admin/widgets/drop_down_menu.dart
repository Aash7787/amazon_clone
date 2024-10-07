import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/controller/bloc/admin_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

  var category = 'mobiles';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {


  @override
  Widget build(BuildContext context) {
    return    SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    // focusColor: Colors.white,
                    items: context
                        .read<AdminBloc>()
                        .productCategories
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
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