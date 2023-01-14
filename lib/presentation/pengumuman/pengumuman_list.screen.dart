import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/colors.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';
import 'package:suheriyatna_mobile/presentation/pengumuman/controllers/pengumuman.controller.dart';
import 'package:suheriyatna_mobile/presentation/pengumuman/pengumuman_add.screen.dart';
import 'package:suheriyatna_mobile/presentation/pengumuman/pengumuman_update.screen.dart';
import 'package:suheriyatna_mobile/presentation/pengumuman/widget/card_pengumuman.widget.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/header_widget.dart';

class PengumumanListScreen extends StatefulWidget {
  const PengumumanListScreen({Key? key}) : super(key: key);

  @override
  State<PengumumanListScreen> createState() => _PengumumanListScreenState();
}

class _PengumumanListScreenState extends State<PengumumanListScreen> {
  PengumumanController pengumumanController = PengumumanController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pengumumanController.getPengumuman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Get.to(() => PengumumanAddScreen());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderWidget(
                isBack: true,
                title: 'Pengumuman',
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(() => Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: pengumumanController.pengumumanList.map((element) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => PengumumanEditScreen(
                                  dataPengumuman: element,
                                ));
                          },
                          child: CardPengumumanWidget(
                            title: element['judul'],
                          ),
                        );
                      }).toList(),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
