import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/colors.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';
import 'package:suheriyatna_mobile/presentation/pengumuman/controllers/pengumuman.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/button_widget.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/header_widget.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/input_field_widget.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/text_area_field_widget.dart';

class PengumumanEditScreen extends StatefulWidget {
  final Map? dataPengumuman;
  const PengumumanEditScreen({Key? key, this.dataPengumuman}) : super(key: key);

  @override
  State<PengumumanEditScreen> createState() => _PengumumanEditScreenState();
}

class _PengumumanEditScreenState extends State<PengumumanEditScreen> {
  PengumumanController pengumumanController = PengumumanController();
  SharedController sharedController = SharedController();

  TextEditingController tJudul = TextEditingController();
  TextEditingController tDeskripsi = TextEditingController();
  String fileName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pengumumanController.filePengumuman = null;
    tJudul.text = widget.dataPengumuman!['judul'];
    tDeskripsi.text = widget.dataPengumuman!['deskripsi'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderWidget(
                title: 'Ubah Pengumuman',
                isBack: true,
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputFieldWidget(
                      title: 'Judul',
                      tController: tJudul,
                      isRequired: true,
                    ),
                    TextAreaWidget(
                      title: 'Deskripsi',
                      tController: tDeskripsi,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'File Pendukung',
                      style: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'pdf', 'png'],
                        );

                        if (result != null) {
                          File file = File(result.files.single.path!);

                          pengumumanController.filePengumuman = file;
                          setState(() {
                            fileName = result.names[0].toString();
                          });
                        } else {}
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 2.h),
                        height: 10.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Remix.file_add_line,
                              color: primaryColor,
                              size: 40.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      padding: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 0.2.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                          color: primaryColor.withOpacity(0.6),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  fileName,
                                  style: defaultTextStyle.copyWith(color: whiteColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ButtonWidget(
                      color: primaryColor,
                      title: 'Ubah',
                      onTap: () {
                        var judul = tJudul.text == null ? '' : tJudul.text;
                        var deskripsi = tDeskripsi.text == null ? '' : tDeskripsi.text;

                        if (tJudul.text.isEmpty) {
                          sharedController.showSnackbar('Gagal', 'Judul tidak boleh kosong');
                        } else {
                          pengumumanController.editPengumuman(widget.dataPengumuman!['id'], deskripsi);
                        }
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ButtonWidget(
                      color: Colors.red,
                      title: 'Hapus',
                      onTap: () {
                        pengumumanController.hapusPengumuman(widget.dataPengumuman!['id']);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
