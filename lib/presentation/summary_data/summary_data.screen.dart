import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/colors.dart';
import 'package:suheriyatna_mobile/presentation/summary_data/tabbar/kuisioner.tabbar.dart';
import 'package:suheriyatna_mobile/presentation/summary_data/tabbar/relawan.tabbar.dart';
import 'package:suheriyatna_mobile/presentation/summary_data/tabbar/timses.tabbar.dart';

import '../../infrastructure/theme/fonts.dart';
import 'controllers/summary_data.controller.dart';

class SummaryDataScreen extends StatefulWidget {
  const SummaryDataScreen({Key? key}) : super(key: key);

  @override
  State<SummaryDataScreen> createState() => _SummaryDataScreenState();
}

class _SummaryDataScreenState extends State<SummaryDataScreen> with SingleTickerProviderStateMixin {
  SummaryDataController summaryDataController = Get.put(SummaryDataController());

  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    summaryDataController.getTotalDataTimses();
    summaryDataController.getTotalDataRelawan();
    summaryDataController.getTotalDataKuisioner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary Data'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                height: 6.h,
                decoration: BoxDecoration(
                  color: greyColor.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                      color: primaryColor,
                    ),
                    labelColor: Color.fromRGBO(238, 248, 254, 1),
                    unselectedLabelColor: primaryColor,
                    unselectedLabelStyle: defaultTextStyle,
                    labelStyle: defaultTextStyle,
                    tabs: [
                      Tab(
                        text: 'Timses',
                      ),
                      Tab(
                        text: 'Relawan',
                      ),
                      Tab(
                        text: 'Kuisioner',
                      ),
                    ],
                  ),
                ),
              ),
              // child: TabBar(
              //   controller: _controller,
              //   tabs: [
              //     Tab(icon: Icon(Icons.x)),
              //     Tab(icon: Icon(Icons.y)),
              //     Tab(icon: Icon(Icons.z)),
              //   ],
              // ),
            ),
          ];
        },
        body: Container(
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              TimsesTabbar(),
              RelawanTabbar(),
              KuisionerTabbar(),
            ],
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      //     child: Column(
      //       children: [
      //         Container(
      //           margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      //           height: 6.h,
      //           decoration: BoxDecoration(
      //             color: greyColor.withOpacity(0.3),
      //             borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(10.0),
      //               topRight: Radius.circular(10.0),
      //               bottomLeft: Radius.circular(10.0),
      //               bottomRight: Radius.circular(10.0),
      //             ),
      //           ),
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(10.0),
      //               topRight: Radius.circular(10.0),
      //               bottomLeft: Radius.circular(10.0),
      //               bottomRight: Radius.circular(10.0),
      //             ),
      //             child: TabBar(
      //               controller: tabController,
      //               indicator: BoxDecoration(
      //                 color: primaryColor,
      //               ),
      //               labelColor: Color.fromRGBO(238, 248, 254, 1),
      //               unselectedLabelColor: primaryColor,
      //               unselectedLabelStyle: defaultTextStyle,
      //               labelStyle: defaultTextStyle,
      //               tabs: [
      //                 Tab(
      //                   text: 'Timses',
      //                 ),
      //                 Tab(
      //                   text: 'Relawan',
      //                 ),
      //                 Tab(
      //                   text: 'Kuisioner',
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         Container(
      //           height: 100.h,
      //           child: TabBarView(
      //             controller: tabController,
      //             children: [
      //               TimsesTabbar(),
      //               RelawanTabbar(),
      //               KuisionerTabbar(),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // )
    );
  }
}
