import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class SelectProductImagesW extends StatelessWidget {
  const SelectProductImagesW({super.key, this.onTap});

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          dashPattern: const [10, 4],
          strokeWidth: 1,
          strokeCap: StrokeCap.round,
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                  strokeAlign: BorderSide.strokeAlignOutside,
                  style: BorderStyle.none),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder_outlined, color: Colors.grey.shade800),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Select Product Images',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
