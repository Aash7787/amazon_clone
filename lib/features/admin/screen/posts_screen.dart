import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/floating_action_btn_w.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  static const pageName = 'postsScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionBtnW(),
      body: Center(),
    );
  }
}
