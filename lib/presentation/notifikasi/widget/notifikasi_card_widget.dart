import 'package:flutter/material.dart';

import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';

import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';

class NotifikasiCardWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? date;
  const NotifikasiCardWidget({Key? key, this.title, this.subtitle, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Remix.error_warning_fill,
            color: primaryColor,
          ),
          SizedBox(
            width: 5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title!, style: defaultTextStyle.copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold)),
              SizedBox(
                width: 70.w,
                child: Text(subtitle!,
                    textAlign: TextAlign.left,
                    maxLines: 3,
                    style: defaultTextStyle.copyWith(
                      fontSize: 11.sp,
                    )),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(date!, style: defaultTextStyle.copyWith(fontSize: 10.sp, color: greyColor)),
            ],
          ),
        ],
      ),
    );
  }
}
