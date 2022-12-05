import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String? title;
  final Color? color;
  final Function()? onTap;
  const ButtonWidget({Key? key, this.title, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0.w,
      height: 6.0.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          title!,
          style: defaultTextStyle.copyWith(fontSize: 12.0.sp, fontWeight: FontWeight.bold, color: whiteColor),
        ),
      ),
    );
  }
}
