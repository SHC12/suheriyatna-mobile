import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';

class CardPengumumanWidget extends StatelessWidget {
  final String? title;
  CardPengumumanWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            height: 13.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                stops: [.5, .5],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  primaryColor,
                  Colors.white,
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: const Offset(0, 3),
              //   ),
              // ],
            ),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                    )),
                Flexible(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          title ?? '',
                          style: whiteTextStyle.copyWith(fontSize: 12.sp),
                          textAlign: TextAlign.right,
                        ))),
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            title ?? '',
            style: defaultTextStyle.copyWith(fontSize: 13.sp, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
