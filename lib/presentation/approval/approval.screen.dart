import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/approval.controller.dart';

class ApprovalScreen extends GetView<ApprovalController> {
  const ApprovalScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ApprovalScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ApprovalScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
