import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';

class MainIconWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function()? onTap;
  MainIconWidget({Key? key, this.title, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20.h,
        width: 42.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40.sp,
              color: primaryColor,
            ),
            SizedBox(height: 1.h),
            Text(
              title!,
              style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
            )
          ],
        ),
      ),
    );
  }
}
