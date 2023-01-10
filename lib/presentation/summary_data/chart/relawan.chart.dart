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

class RelawanChart extends StatefulWidget {
  RelawanChart();

  @override
  State<RelawanChart> createState() => _RelawanChartState();
}

class _RelawanChartState extends State<RelawanChart> {
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
                  data: summaryDataController.chartDataKabupatenRelawan.value.map((element) {
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
                    return "${pieData['domain'].toString().replaceAll(' ', '\n')}:\n${pieData['measure'].toStringAsFixed(2)}%";
                  },
                  labelPosition: PieLabelPosition.outside,
                ),
              ),
            )),
        Text('Chart Kecamatan', style: defaultTextStyle),
        SizedBox(
          height: 1.h,
        ),
        Obx(() => Container(
              margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 2.h),
              child: AspectRatio(
                aspectRatio: 16 / 6,
                child: DChartPie(
                  data: summaryDataController.chartDataKecamatanRelawan.value.map((element) {
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
                  data: summaryDataController.chartDataKelurahanRelawan.value.map((element) {
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
