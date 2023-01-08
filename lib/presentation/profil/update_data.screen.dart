import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:suheriyatna_mobile/presentation/profil/profil.screen.dart';

import '../shared/widget/header_widget.dart';

class UpdateDataScreen extends StatefulWidget {
  const UpdateDataScreen({Key? key}) : super(key: key);

  @override
  State<UpdateDataScreen> createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          HeaderWidget(
            isHome: false,
            title: 'Data Saya',
            isBack: true,
            onTap: () {
              Get.to(() => ProfilScreen());
            },
          ),
        ],
      )),
    );
  }
}
