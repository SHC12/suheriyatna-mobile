import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import '../../../infrastructure/theme/colors.dart';

class CustomDialogWidget extends StatelessWidget {
  final String? message;
  const CustomDialogWidget({Key? key, this.message}) : super(key: key);

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
            padding: EdgeInsets.only(
              top: 1.0.h,
            ),
            margin: EdgeInsets.only(top: 2.0.h, right: 2.0.w),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                    child: Container(
                  margin: EdgeInsets.all(6.0.h),
                  child: Text(message!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0.sp,
                      )),
                )),

                // InkWell(
                //   child: Container(
                //     padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.only(
                //           bottomLeft: Radius.circular(16.0),
                //           bottomRight: Radius.circular(16.0)),
                //     ),
                //     child: Text(
                //       "OK",
                //       style: TextStyle(color: Colors.blue, fontSize: 25.0),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // )
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: secondaryColor,
                  child: Icon(Icons.close, color: whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
