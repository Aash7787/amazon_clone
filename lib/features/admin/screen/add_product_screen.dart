import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/btn_w.dart';
import 'package:flutter_amazon_clone/common/widgets/my_text_form_field_w.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/admin/controller/bloc/admin_bloc.dart';
import 'package:flutter_amazon_clone/features/admin/service/admin_service.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/carousel_slider_image_w.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/drop_down_menu.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/select_product_images_w.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  static const pageName = 'addProductScreen';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController productNameController;

  late TextEditingController descriptionController;

  late TextEditingController priceController;

  late TextEditingController quantityController;

  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    productNameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    Future<void> selectImages() async {
      images = await pickImages(context);
      if (images.isNotEmpty) {
        context.read<AdminBloc>().add(
              SelectProductImagesEvent(images),
            );
      }
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables
                .appBarGradient, // Use the gradient from GlobalVariables
          ),
        ),
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _addProductFormKey,
            child: Column(
              children: [
                BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is AdminSelectProductImage &&
                        state.selectedImages.isNotEmpty) {
                      // Pass the selected images to CarouselSliderImageW
                      return Column(
                        children: [
                          Stack(
                            children: [
                              CarouselSliderImageW(
                                  images: state.selectedImages),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    selectImages();
                                  },
                                  icon: const Icon(Icons.refresh),
                                ),
                              ),
                            ],
                          ), // Pass images
                          const SizedBox(height: 30),
                        ],
                      );
                    } else {
                      return SelectProductImagesW(
                        onTap: () {
                          selectImages();
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
                MyTextFormFieldW(
                  hint: 'Product Name',
                  textEditingController: productNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFormFieldW(
                  hint: 'Description',
                  maxLines: 7,
                  textEditingController: descriptionController,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFormFieldW(
                  hint: 'Price',
                  textEditingController: priceController,
                  keyboardType: TextInputType.number,
                ),
                MyTextFormFieldW(
                  hint: 'Quantity',
                  textEditingController: quantityController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                const DropDownMenu(),
                BtnW(
                  btnText: 'Confirm ',
                  onTap: _sellProduct,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sellProduct() {
    if (_addProductFormKey.currentState!.validate() &&
        context.read<AdminBloc>().images.isNotEmpty) {
      log('$images');
      AdminService().sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: int.parse(quantityController.text),
          category: category,
          images: images);
    } else {
      if (context.read<AdminBloc>().images.isEmpty) {
        showSnackBar(context, 'Add images');
      } else {
        showSnackBar(context, 'Fill up the fields');
      }
    }
  }
}
