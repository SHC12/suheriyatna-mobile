import 'dart:math';

import 'package:d_chart/d_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/summary_data/controllers/summary_data.controller.dart';

import 'indicator/indicator.dart';

class TimsesChart extends StatefulWidget {
  TimsesChart();

  @override
  State<TimsesChart> createState() => _TimsesChartState();
}

class _TimsesChartState extends State<TimsesChart> {
  SharedController sharedController = Get.put(SharedController());
  SummaryDataController summaryDataController = Get.put(SummaryDataController());
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Chart Kabupaten', style: defaultTextStyle),
        SizedBox(
          height: 1.h,
        ),
        Obx(() => Container(
              child: AspectRatio(
                aspectRatio: 16 / 6,
                child: DChartPie(
                  data: summaryDataController.chartDataKabupaten.value.map((element) {
                    return {
                      'domain': element['name'].toString().replaceAll('KABUPATEN ', ''),
                      'measure': element['value']
                    };
                  }).toList(),
                  fillColor: (pieData, index) {
                    switch (pieData['domain']) {
                      case 'KOTA TARAKAN':
                        return Colors.blue;
                      case 'TANA TIDUNG':
                        return Color.fromARGB(255, 64, 105, 177);
                      case 'MALINAU':
                        return Color.fromARGB(255, 18, 235, 145);
                      case 'BULUNGAN':
                        return Color.fromARGB(255, 195, 213, 56);
                      case 'NUNUKAN':
                        return Color.fromARGB(255, 222, 51, 231);
                      default:
                        return Colors.orange;
                    }
                  },
                  pieLabel: (pieData, index) {
                    return "${pieData['domain']}:\n${pieData['measure'].toStringAsFixed(2)}%";
                  },
                  labelPosition: PieLabelPosition.outside,
                ),
              ),
            )),
      ],
    );
    // return AspectRatio(
    //   aspectRatio: 2,
    //   child: Card(
    //     // color: Colors.white,
    //     child: Row(
    //       children: <Widget>[
    //         const SizedBox(
    //           height: 18,
    //         ),
    //         Expanded(
    //           child: AspectRatio(
    //             aspectRatio: 1,
    //             child: PieChart(
    //               PieChartData(
    //                 pieTouchData: PieTouchData(
    //                   touchCallback: (FlTouchEvent event, pieTouchResponse) {
    //                     setState(() {
    //                       if (!event.isInterestedForInteractions ||
    //                           pieTouchResponse == null ||
    //                           pieTouchResponse.touchedSection == null) {
    //                         touchedIndex = -1;
    //                         return;
    //                       }
    //                       touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
    //                     });
    //                   },
    //                 ),
    //                 borderData: FlBorderData(
    //                   show: false,
    //                 ),
    //                 sectionsSpace: 0,
    //                 centerSpaceRadius: 40,
    //                 sections: showingSections(),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: const <Widget>[
    //             Indicator(
    //               color: Color(0xff0293ee),
    //               text: 'Kabupaten Malinau',
    //               isSquare: true,
    //             ),
    //             SizedBox(
    //               height: 4,
    //             ),
    //             Indicator(
    //               color: Color(0xfff8b250),
    //               text: 'Kabupaten Bulungan',
    //               isSquare: true,
    //             ),
    //             SizedBox(
    //               height: 4,
    //             ),
    //             Indicator(
    //               color: Color(0xff845bef),
    //               text: 'Kabupaten Tana Tidung',
    //               isSquare: true,
    //             ),
    //             SizedBox(
    //               height: 4,
    //             ),
    //             Indicator(
    //               color: Color(0xff13d38e),
    //               text: 'Kabupaten Nunukan',
    //               isSquare: true,
    //             ),
    //             SizedBox(
    //               height: 18,
    //             ),
    //             Indicator(
    //               color: Color(0xff13d38e),
    //               text: 'Kota Tarakan',
    //               isSquare: true,
    //             ),
    //             SizedBox(
    //               height: 18,
    //             ),
    //           ],
    //         ),
    //         const SizedBox(
    //           width: 28,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
