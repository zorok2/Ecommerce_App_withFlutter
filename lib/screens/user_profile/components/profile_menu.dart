import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/constant.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    required this.press,
  });

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor.withOpacity(0.7),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
          onPressed: press,
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 22,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(text, style: const TextStyle(color: Colors.white)),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          )),
    );
  }
}
