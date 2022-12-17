import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/colors.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/button_widget.dart';

import 'controllers/role.controller.dart';

class RoleScreen extends GetView<RoleController> {
  const RoleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: Container(
                  alignment: Alignment.center,
                  child: Center(
                      child: Image.asset(
                    'assets/images/main_logo_transparent.png',
                    width: 35.w,
                  )),
                ),
                flex: 1,
              ),
              Flexible(
                // ignore: sort_child_properties_last
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Selamat Datang di',
                              style: defaultPrimaryTextStyle.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              'Suheriyatna Mobile !',
                              style: defaultPrimaryTextStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        'Masuk sebagai ?',
                        style: defaultTextStyle.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ButtonWidget(
                        color: secondaryColor,
                        title: 'Relawan',
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ButtonWidget(
                        color: secondaryColor,
                        title: 'DTDC',
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ButtonWidget(
                        color: secondaryColor,
                        title: 'Quick Count',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                flex: 2,
              ),
            ],
          ),
        ));
  }
}
