import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/colors.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';

class CardListKuisionerWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Function()? onTap;
  const CardListKuisionerWidget({Key? key, this.title, this.subtitle, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0.0, 0.0),
          )
        ], color: whiteColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title!,
              style: defaultPrimaryTextStyle,
            ),
            // SizedBox(
            //   height: 1.h,
            // ),
            // Text(
            //   subtitle!,
            //   style: defaultTextStyle,
            // ),
          ],
        ),
      ),
    );
  }
}
