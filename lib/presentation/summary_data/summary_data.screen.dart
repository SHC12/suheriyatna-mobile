import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/summary_data.controller.dart';

class SummaryDataScreen extends GetView<SummaryDataController> {
  const SummaryDataScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SummaryDataScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SummaryDataScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
