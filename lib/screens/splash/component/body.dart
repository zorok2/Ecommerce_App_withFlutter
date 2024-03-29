import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/configs/constant.dart';
import 'package:ecommerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce_app/screens/splash/component/splash_content.dart';
import 'package:flutter/material.dart';

import '../../../widget/default_button.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Map<String, String>> splashData = [
    {
      "text": "Chào mừng bạn đến với HealthyCare Shop",
      "image":
          "assets/animations/47336-online-shopping-search-product-concept-animation.json"
    },
    {
      "text": "mọi người có thể liên hệ đến\n cửa hàng xung quanh Việt Nam",
      "image":
          "assets/animations/47779-product-delivery-and-sign-in-the-paper.json"
    },
    {
      "text": "Chúng tôi luôn đặt bạn lên hàng đầu . \nHãy đến với chúng tôi",
      "image": "assets/animations/100563-add-to-product.json"
    },
    {
      "text": "Sự hài lòng của bạn\nlà ánh sáng của chúng tôi",
      "image": "assets/animations/newScene.json"
    },
  ];
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: CarouselSlider.builder(
                      itemCount: splashData.length,
                      itemBuilder: (context, index, realIndex) {
                        return SplashContent(
                            text: splashData[index]["text"]!,
                            image: splashData[index]["image"]!);
                      },
                      options: CarouselOptions(
                          aspectRatio: 16 / 12,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          scrollDirection: Axis.horizontal)),
                ),
                // child: PageView.builder(
                //   onPageChanged: (value) {
                //     setState(() {
                //       currentPage = value;
                //     });
                //   },
                //   itemCount: splashData.length,
                //   itemBuilder: (context, index) => SplashContent(
                //     text: splashData[index]["text"]!,
                //     image: splashData[index]["image"]!,
                //   ),
                // )),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                  splashData.length, (index) => buildDot(index))
                            ],
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          DefaultButton(
                            text: 'Tiếp tục',
                            press: () {
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            },
                          ),
                          const Spacer(),
                        ],
                      ),
                    ))
              ],
            )));
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      width: currentPage == index ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : const Color(0XFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
