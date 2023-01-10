import 'dart:math' as math;
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
              margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 2.h),
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
                    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
                  },
                  pieLabel: (pieData, index) {
                    return "${pieData['domain'].toString().replaceAll(' ', '\n')}:\n${pieData['measure'].toStringAsFixed(2)}%";
                  },
                  labelPosition: PieLabelPosition.outside,
                ),
              ),
            )),
        SizedBox(
          height: 2.h,
        ),
        Text('Chart Kecamatan', style: defaultTextStyle),
        SizedBox(
          height: 1.h,
        ),
        Obx(() => Container(
              margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 2.h),
              child: AspectRatio(
                aspectRatio: 16 / 6,
                child: DChartPie(
                  data: summaryDataController.chartDataKecamatan.value.map((element) {
                    return {
                      'domain': element['name'].toString().replaceAll('KABUPATEN ', ''),
                      'measure': element['value']
                    };
                  }).toList(),
                  fillColor: (pieData, index) {
                    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
                  },
                  pieLabel: (pieData, index) {
                    return "${pieData['domain'].toString().replaceAll(' ', '\n')}:\n${pieData['measure'].toStringAsFixed(2)}%";
                  },
                  labelPosition: PieLabelPosition.outside,
                ),
              ),
            )),
        Text('Chart Kelurahan', style: defaultTextStyle),
        SizedBox(
          height: 1.h,
        ),
        Obx(() => Container(
              margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 2.h),
              child: AspectRatio(
                aspectRatio: 16 / 6,
                child: DChartPie(
                  data: summaryDataController.chartDataKelurahan.value.map((element) {
                    return {
                      'domain': element['name'].toString().replaceAll('KABUPATEN ', ''),
                      'measure': element['value']
                    };
                  }).toList(),
                  fillColor: (pieData, index) {
                    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
                  },
                  pieLabel: (pieData, index) {
                    return "${pieData['domain'].toString().replaceAll(' ', '\n')}:\n${pieData['measure'].toStringAsFixed(2)}%";
                  },
                  labelPosition: PieLabelPosition.outside,
                ),
              ),
            )),
      ],
    );
  }
}
