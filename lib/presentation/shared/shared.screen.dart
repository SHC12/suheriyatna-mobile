import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/shared.controller.dart';

class SharedScreen extends GetView<SharedController> {
  const SharedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SharedScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
