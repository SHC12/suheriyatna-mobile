import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';

import '../../login/login.screen.dart';

class HeaderOperatorWidget extends StatelessWidget {
  final bool? isBack;
  final String? title;
  final bool? isHome;
  HeaderOperatorWidget({Key? key, this.isBack, this.title, this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              if (isBack == true) {
                Get.back();
              }
            },
            child: Icon(isBack == null || isBack == false ? Remix.bar_chart_horizontal_line : Remix.arrow_left_line,
                color: whiteColor),
          ),
          Text(title!, style: headTextStyle.copyWith(color: whiteColor)),
          GestureDetector(
            onTap: () {
              if (isHome != null || isHome == true) {
                Get.to(LoginScreen());
              } else {}
            },
            child: Icon(
              isHome != null || isHome == true ? Remix.logout_circle_r_line : Remix.notification_3_line,
              color: whiteColor,
            ),
          )
        ],
      ),
    );
  }
}
