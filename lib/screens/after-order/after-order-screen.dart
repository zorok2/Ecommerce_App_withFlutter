import 'package:ecommerce_app/controller/get_cart_user_controller.dart';
import 'package:ecommerce_app/controller/login_account_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../configs/constant.dart';
import '../../controller/order_controller.dart';
import '../../root.dart';
import '../../widget/show_loading_animation.dart';
import '../pay_history/pay_history_screen.dart';

class ThanksForBuying extends StatelessWidget {
  ThanksForBuying({Key? key}) : super(key: key);
  static String routeName = "/thanks";
  final cartController = Get.find<GetCartUserController>();
  final orderController = Get.find<OrderController>();
  final LoginAccountInfoController userController =
      Get.find<LoginAccountInfoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/animations/Comp.json",
              height: 340,
              width: 300,
            ),
            const Text(
              'Thanks for buying!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Đơn hàng của bạn đang được xử lý',
              style: TextStyle(
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor, // Set the color here
                  ),
                  onPressed: () async {
                    showLoadingAnimation(context);
                    await cartController.getCartUser(userController.user.id!);
                    orderController.loadListOrder(userController.user.id!);
                    await Future.delayed(
                      const Duration(milliseconds: 1700),
                      () => Get.back(),
                    );

                    Get.toNamed(PayHistoryScreen.routeName);
                  },
                  child: const Text('Xem đơn hàng'),
                ),
                const SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor, // Set the color here
                  ),
                  onPressed: () async {
                    showLoadingAnimation(context);
                    await cartController.getCartUser(userController.user.id!);
                    // await orderController.loadListOrder(userController.user!.id!);
                    Get.back();
                    Get.off(() => const RootApp());
                  },
                  child: const Text('Tiếp tục mua sắm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
