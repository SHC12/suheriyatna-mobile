import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';
import 'package:suheriyatna_mobile/presentation/pengumuman/pengumuman.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/header_widget.dart';

class PengumumanDetailScreen extends StatefulWidget {
  final Map? dataPengumuman;
  const PengumumanDetailScreen({Key? key, this.dataPengumuman}) : super(key: key);

  @override
  State<PengumumanDetailScreen> createState() => _PengumumanDetailScreenState();
}

class _PengumumanDetailScreenState extends State<PengumumanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              title: 'Detail Pengumuman',
              isBack: true,
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dataPengumuman!['judul'],
                    style: headTextStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    widget.dataPengumuman!['deskripsi'] ?? '',
                    style: defaultTextStyle,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Visibility(
                    visible: widget.dataPengumuman!['file_pendukung'] == null ? false : true,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.dataPengumuman!['file_pendukung'].toString().contains('.pdf')) {
                          Get.to(() => PengumumanScreen(
                                false,
                                url: widget.dataPengumuman!['file_pendukung'],
                              ));
                        } else {
                          final imageProvider =
                              Image.network(widget.dataPengumuman!['file_pendukung'].toString()).image;
                          showImageViewer(context, imageProvider, onViewerDismissed: () {
                            print("dismissed");
                          });
                        }
                      },
                      child: Text(
                        'Klik disini untuk melihat lampiran  ',
                        style: defaultPrimaryTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
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
