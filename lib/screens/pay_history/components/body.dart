import 'package:ecommerce_app/configs/constant.dart';
import 'package:ecommerce_app/controller/login_account_info_controller.dart';
import 'package:ecommerce_app/controller/order_controller.dart';
import 'package:ecommerce_app/screens/pay_history/components/pay_history_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/get_cart_user_controller.dart';
import '../../pay-order-detail/pay-order-detail-screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final orderController = Get.find<OrderController>();

  final userController = Get.find<LoginAccountInfoController>();

  final controller = Get.find<GetCartUserController>();
  late Future orderFuture;
  @override
  void initState() {
    // TODO: implement initState
    orderFuture = orderController.loadListOrder(userController.user.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        setState(() async {
          orderFuture =
              await orderController.loadListOrder(userController.user.id!);
        });
      },
      child: FutureBuilder(
        future: orderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20 * (MediaQuery.of(context).size.width) / 375),
                child: Obx(
                  () => orderController.listAllOrder.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: orderController.listAllOrder.length,
                          itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text.rich(TextSpan(
                                        text: orderController
                                            .listAllOrder[index].status,
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                        ))),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Get.to(() => OrderDetailsScreen(
                                              orderId: orderController
                                                  .listAllOrder[index].id!,
                                              orderDetails: orderController
                                                  .listAllOrder[index]
                                                  .orderDetail!,
                                            ));
                                      },
                                      child: PayHistoryItem(
                                          detail: orderController
                                              .listAllOrder[index]
                                              .orderDetail![0])),
                                  const Divider(thickness: 1),
                                  Row(
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                            text:
                                                'Số lượng sản phẩm: ${orderController.listAllOrder[index].orderDetail!.length}'),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const Spacer(),
                                      Text(
                                          'Tổng tiền: ${NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(orderController.listAllOrder[index].totalPrice)}',
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  )
                                ],
                              )))
                      : SizedBox(
                          width: Get.width,
                          height: Get.height,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  child: const Center(
                                    child: Icon(
                                      Icons.local_mall_outlined,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                const Text(
                                  "Bạn chưa đặt hàng\nKhi bạn đặt hàng,\n chúng sẽ xuất hiện ở đây",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      height: 1.2,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.5),
                                )
                              ]),
                        ),
                ));
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
    );
  }
}
