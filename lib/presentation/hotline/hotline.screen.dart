import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../infrastructure/theme/colors.dart';
import '../shared/widget/header_widget.dart';
import 'controllers/hotline.controller.dart';

class HotlineScreen extends GetView<HotlineController> {
  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+6282345596799',
      text: "Hallo",
    );

    await launch('$link');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: SafeArea(
            top: false,
            child: Column(
              children: [
                HeaderWidget(
                  isBack: true,
                  title: 'Info Hotline',
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await FlutterPhoneDirectCaller.callNumber("082345596799");
                            },
                            child: Container(
                              width: 50.0.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Remix.customer_service_2_line, color: primaryColor),
                                  SizedBox(
                                    width: 3.0.w,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hubungi Kami',
                                        style: defaultTextStyle.copyWith(fontSize: 10.0.sp),
                                      ),
                                      Text('+62 823-4559-6799',
                                          style: defaultTextStyle.copyWith(fontSize: 10.0.sp, color: greyColor)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              launchWhatsApp();
                            },
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Remix.whatsapp_line, color: primaryColor),
                                  SizedBox(
                                    width: 3.0.w,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Whatsapp',
                                        style: defaultTextStyle.copyWith(fontSize: 10.0.sp),
                                      ),
                                      Text('+62 823-4559-6799',
                                          style: defaultTextStyle.copyWith(fontSize: 10.0.sp, color: greyColor)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      Text('Kantor Sobat Bang Yana ',
                          style: defaultTextStyle.copyWith(fontSize: 12.0.sp, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jl. xxxxxx. No. xx',
                              style: defaultTextStyle.copyWith(
                                  fontSize: 10.0.sp, color: greyColor, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
