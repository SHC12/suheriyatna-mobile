import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';

import '../../../infrastructure/theme/colors.dart';

class ConfirmDialogWidget extends StatelessWidget {
  final String? titleMessage;
  final String? message;
  final String? titleButtonYes;
  final String? titleButtonNo;
  final Function()? onTapYes;
  final bool? isButton;
  const ConfirmDialogWidget(
      {Key? key,
      this.message,
      this.titleMessage,
      this.titleButtonYes,
      this.titleButtonNo,
      this.onTapYes,
      this.isButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 80.w,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(titleMessage!,
                          textAlign: TextAlign.center, style: defaultTextStyle.copyWith(fontSize: 12.sp)),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Remix.close_line,
                          color: greyColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(message!, textAlign: TextAlign.center, style: greyTextStyle.copyWith(fontSize: 10.sp)),
                Visibility(
                  visible: isButton ?? false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: whiteColor),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(titleButtonNo!, style: greyTextStyle.copyWith(fontSize: 12.sp)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                        child: RaisedButton(
                          onPressed: onTapYes,
                          color: primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          child: Text(titleButtonYes!, style: whiteTextStyle.copyWith(fontSize: 12.sp)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
