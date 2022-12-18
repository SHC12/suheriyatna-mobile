import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/notifikasi/notifikasi.screen.dart';
import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';
import '../../login/login.screen.dart';

class HeaderWidget extends StatelessWidget {
  final bool? isBack;
  final String? title;
  final bool? isHome;
  final Function()? onTap;
  HeaderWidget({Key? key, this.isBack, this.title, this.isHome, this.onTap}) : super(key: key);

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: isBack == true ? () => Get.back() : onTap,
                // onTap: () {
                //   if (isBack == true) {
                //     Get.back();
                //   }else{

                //   }
                // },
                child: Icon(isBack == null || isBack == false ? Remix.user_line : Remix.arrow_left_line,
                    color: whiteColor),
              ),
              Text(title!, style: headTextStyle.copyWith(color: whiteColor)),
              GestureDetector(
                onTap: () {
                  if (isHome != null || isHome == true) {
                    prefs.erase();
                    Get.offAll(LoginScreen());
                  } else {
                    Get.to(NotifikasiScreen());
                  }
                },
                child: Icon(
                  isHome == true ? Remix.logout_circle_r_line : Remix.notification_3_line,
                  color: whiteColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
