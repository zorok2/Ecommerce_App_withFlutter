import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/constant.dart';
import '../../../controller/update-total-controller.dart';
import '../../pay_cart/pay_cart_screen.dart';

class BottomNavigation extends StatelessWidget {
  final TotalController controller = Get.put(TotalController());

  BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.9),
            )
          ]),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text.rich(TextSpan(
                    text: "Tổng thanh toán: ",
                  )),
                  Obx(() => Text('${controller.total}')), // data 0
                ],
              ),
              const SizedBox(
                width: 23.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.3,
                height: 50,
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: kPrimaryColor,
                    ),
                    onPressed: () {
                      //call api create order dùng get
                      Get.toNamed(PayCartScreen.routeName);
                      // Navigator.pushAndRemoveUntil<dynamic>(
                      //     context,
                      //     MaterialPageRoute<dynamic>(
                      //       builder: (context) => const PayCartScreen(),
                      //     ),
                      //     (route) => true);
                    },
                    child: Obx(() => Text('Thanh toán (${controller.count})')),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
