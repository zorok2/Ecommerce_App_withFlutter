import 'dart:convert';

import 'package:ecommerce_app/api/user/fetch_api_service.dart';
import 'package:ecommerce_app/configs/size_config.dart';
import 'package:ecommerce_app/controller/auth_controller.dart';
import 'package:ecommerce_app/controller/login_account_info_controller.dart';
import 'package:ecommerce_app/root.dart';
import 'package:ecommerce_app/screens/splash/component/body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

import '../../controller/favourite_controller.dart';
import '../../controller/get_cart_user_controller.dart';
import '../../controller/order-detail-controller.dart';
import '../../controller/order_controller.dart';
import '../../controller/product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void loadController() async {
    final CreateOrderController createCartController =
        Get.put(CreateOrderController());
    final orderController = Get.put(OrderController());
    final orderDetailController = Get.put(OrderDetailController());
    final controller1 = Get.put(ProductController());
    final authController = Get.put(AuthController());
    final favouriveController = Get.put(FavouriteController());
    final loginAccountController = Get.put(LoginAccountInfoController());
    final cartController = Get.put(GetCartUserController());
  }

  late LoginAccountInfoController controllerAccInfo;
  late GetCartUserController cartController;

  String? accessToken;
  bool isLogin = false;

  Future<void> checkIfLogin() async {
    final controllerAccount = Get.find<LoginAccountInfoController>();
    String token = controllerAccount.accessToken;
    Map<String, dynamic> decodeToken = JwtDecoder.decode(token);

    Logger().d('token đã giải mã  $decodeToken');

    int expireTime = decodeToken['exp'];

    DateTime expireDate =
        DateTime.fromMillisecondsSinceEpoch(expireTime * 1000);
    String formattedDate =
        "${expireDate.day}/${expireDate.month}/${expireDate.year}";
    print("Token hết hạn vào ngày $formattedDate");

    if (!JwtDecoder.isExpired(token) && token != "") {
      final response =
          await FetchApiUserService.instance.getUserById(decodeToken['userId']);
      final userData = response!.data;
      User user = User(
          id: userData?.id,
          email: userData?.email,
          fullname: userData?.fullname,
          phone: userData?.phone,
          username: userData?.username,
          avatarUrl: userData?.avatarUrl);
      controllerAccInfo.setUser = user;

      await cartController.getCartUser(userData!.id!);
      Logger().d(jsonEncode(user));

      setState(() {
        accessToken = token;
        isLogin = true;
      });
    } else {
      loginOut();
    }
  }

  void login(String accessToken) async {
    final controllerAccount = Get.find<LoginAccountInfoController>();

    String token = controllerAccount.accessToken;

    setState(() {
      accessToken = token;
      isLogin = true;
    });
  }

  void loginOut() {
    final controllerAccount = Get.find<LoginAccountInfoController>();
    controllerAccount.removeToken('accessToken');
    setState(() {
      accessToken = "";
      isLogin = false;
    });
  }

  @override
  void initState() {
    loadController();
    checkIfLogin();
    controllerAccInfo = Get.find<LoginAccountInfoController>();
    cartController = Get.find<GetCartUserController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    if (!isLogin) {
      return const Scaffold(
        body: Body(),
      );
    } else {
      return const RootApp();
    }
  }
}
