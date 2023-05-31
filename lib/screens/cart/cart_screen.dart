// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../controller/get_cart_user_controller.dart';
import 'components/bottom_nagivation.dart';
import 'package:ecommerce_app/screens/cart/components/body.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart';

  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: const Body(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
