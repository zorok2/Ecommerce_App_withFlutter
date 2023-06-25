import 'package:ecommerce_app/api/auth/login_account.dart';
import 'package:ecommerce_app/configs/constant.dart';
import 'package:ecommerce_app/controller/auth_controller.dart';
import 'package:ecommerce_app/controller/login_account_info_controller.dart';
import 'package:ecommerce_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:ecommerce_app/screens/sign_in/components/customSuffixIcon.dart';
import 'package:ecommerce_app/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/constant.dart';
import '../../../controller/get_cart_user_controller.dart';
import '../../../root.dart';
import '../../../widget/default_button.dart';
import '../../../widget/form_err.dart';
import '../../../widget/show_loading_animation.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool isShowPass = true;
  late LoginAccountInfoController controller;
  late AuthController authController;

  late GetCartUserController cartController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find<LoginAccountInfoController>();
    authController = Get.find<AuthController>();
    cartController = Get.find<GetCartUserController>();
  }

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool remember = false;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        buildEmailField(),
        const SizedBox(
          height: 30,
        ),
        buildPasswordField(),
        const SizedBox(
          height: 30,
        ),
        FormError(errors: errors),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Obx(
              () => Checkbox(
                activeColor: kPrimaryColor,
                hoverColor: kPrimaryColor,
                value: authController.isRemember.value,
                shape: const CircleBorder(),
                onChanged: (value) {
                  setState(() {
                    authController.isRemember.value = value!;
                  });
                },
              ),
            ),
            const Text('Nhớ mật khẩu'),
            const Spacer(),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
              child: const Text(
                'Quên mật khẩu',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
        DefaultButton(
          text: 'Tiếp tục ',
          press: () async {
            if (_formKey.currentState!.validate() == true) {
              _formKey.currentState?.save();
              if (authController.isRemember.value) {
                authController.saveCredentials(
                    email!, password!, authController.isRemember.value);
              } else {
                authController.saveCredentials('', '', false);
              }
              showLoadingAnimation(context);
              final response = await ApiLogin.login(email!, password!);

              if (response.message == 'Incorrect account or password') {
                setState(() {
                  if (!errors.contains(kInvalidUsernamePassword)) {
                    errors.add(kInvalidUsernamePassword);
                  }
                  if (errors.contains(kExistAccount)) {
                    errors.remove(kExistAccount);
                  }
                });
                Get.back();

                return;
              } else if (response.message == 'User not found') {
                setState(() {
                  if (!errors.contains(kExistAccount)) {
                    errors.add(kExistAccount);
                  }
                  if (errors.contains(kInvalidUsernamePassword)) {
                    errors.remove(kInvalidUsernamePassword);
                  }
                });
                Get.back();

                return;
              }
              final userData = response.data?.userStored;
              UserModel user = UserModel(
                  id: userData?.id,
                  email: userData?.email,
                  fullname: userData?.fullname,
                  phone: userData?.phone,
                  username: userData?.username,
                  avatarUrl: userData?.avatarUrl);
              controller.setUser = user;
              controller.accessToken = response.data?.accessToken;
              controller.refreshToken = response.data?.refreshToken;
              controller.saveAccessToken();
              accesstokenn = response.data?.accessToken ?? "";
              await cartController.getCartUser(controller.user.id!);
              Get.back();
              Get.offNamed(RootApp.routeName);
            }
          },
        ),
      ]),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      style: const TextStyle(fontSize: 18),
      initialValue: authController.password.value,
      onChanged: (value) {
        if (value.isNotEmpty == true && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
      },
      validator: (value) {
        if (value?.isEmpty == true && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        } else if (value!.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
          return "";
        }
        return null;
      },
      onSaved: (newValue) => password = newValue,
      obscureText: isShowPass,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: 'Nhập mật khẩu',
          labelText: 'Mật khẩu',
          labelStyle: const TextStyle(fontSize: 18),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isShowPass = !isShowPass;
              });
            },
            child: const CustomSuffix(
              svgIcon: 'assets/icons/Lock.svg',
            ),
          )),
    );
  }

  Widget buildEmailField() {
    return Obx(
      () => TextFormField(
        style: const TextStyle(fontSize: 18),
        initialValue: authController.username.value,
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
          if (value.isNotEmpty == true && errors.contains(kUserNullError)) {
            setState(() {
              errors.remove(kUserNullError);
            });
          }
        },
        validator: (value) {
          if (value?.isEmpty == true && !errors.contains(kUserNullError)) {
            setState(() {
              errors.add(kUserNullError);
            });
            return "";
          }
          return null;
        },
        cursorColor: Colors.black,
        decoration: const InputDecoration(
            labelStyle: TextStyle(fontSize: 20),
            hintText: 'Nhập tài khoản ',
            labelText: 'Tài khoản',
            suffixIcon: CustomSuffix(
              svgIcon: 'assets/icons/User.svg',
            )),
      ),
    );
  }
}
