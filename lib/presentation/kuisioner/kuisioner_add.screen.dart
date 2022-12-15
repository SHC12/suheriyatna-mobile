import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../notifikasi/notifikasi.screen.dart';
import '../registration/controllers/registration.controller.dart';
import '../shared/controllers/shared.controller.dart';
import '../shared/widget/button_widget.dart';
import '../shared/widget/dropdown_field_widget.dart';
import '../shared/widget/input_field_widget.dart';
import 'controllers/kuisioner.controller.dart';

class KuisionerAddScreen extends StatefulWidget {
  const KuisionerAddScreen({Key? key}) : super(key: key);

  @override
  State<KuisionerAddScreen> createState() => _KuisionerAddScreenState();
}

class _KuisionerAddScreenState extends State<KuisionerAddScreen> {
  KuisionerController kuisionerController = Get.put(KuisionerController());
  RegistrationController registrationController = Get.put(RegistrationController());
  SharedController sharedController = Get.put(SharedController());

  TextEditingController tNamaLengkap = TextEditingController();
  var jenisKelaminValue;
  var kabupatenValue;
  var kecamatanValue;
  var kabupatenStringValue;
  var kecamatanStringValue;
  var kelurahanStringValue;
  var kelurahanValue;
  var mengenalValue;

  var jenisKelaminList = [
    {'nama': 'Laki-laki', 'status': 'laki-laki'},
    {'nama': 'Perempuan', 'status': 'perempuan'},
  ];
  var mengenalList = [
    {'nama': 'Ya', 'status': 'ya'},
    {'nama': 'Tidak', 'status': 'tidak'},
  ];
  final ImagePicker _picker = ImagePicker();

  XFile? opsionalImage;

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Gallery'),
                  ],
                ),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Ambil Photo'),
                  ],
                ),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
              ),
            ],
          );
        });
  }

  getImage(ImageSource source) async {
    XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      // File fileImage = File(image.path);
      setState(() {
        opsionalImage = image;
        Get.back(closeOverlays: true);
        print('sukses');
      });
    } else {
      setState(() {
        Get.back(closeOverlays: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Remix.arrow_left_line, color: whiteColor),
                    ),
                    Text('Tambah Kuisioner', style: headTextStyle.copyWith(color: whiteColor)),
                    GestureDetector(
                      onTap: () => Get.to(() => NotifikasiScreen()),
                      child: Icon(
                        Remix.notification_3_line,
                        color: whiteColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputFieldWidget(
                  title: 'Nama Lengkap',
                  tController: tNamaLengkap,
                  isRequired: true,
                ),
                DropdownFieldWidget(
                  title: 'Jenis Kelamin',
                  value: jenisKelaminValue,
                  listValue: jenisKelaminList,
                  valueName: 'status',
                  listName: 'nama',
                  itemCallback: (String value) {
                    jenisKelaminValue = value;
                  },
                ),
                Obx(() => Container(
                      width: double.infinity,
                      child: DropdownFieldWidget(
                        title: 'Kabupaten',
                        listValue: registrationController.kabupatenList.value,
                        value: kabupatenValue,
                        isRequired: true,
                        listName: 'name',
                        valueName: 'id',
                        itemCallback: (String value) {
                          kabupatenValue = value;
                          registrationController.fetchKecamatan(value);
                          var kabupatenTempValue = registrationController.kabupatenList.value
                              .where((element) => element['id'] == value)
                              .toList();

                          kabupatenStringValue = kabupatenTempValue[0]['name'];
                          kecamatanValue = null;
                          kelurahanValue = null;
                        },
                      ),
                    )),
                Obx(() => Container(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: DropdownFieldWidget(
                              title: 'Kecamatan',
                              listValue: registrationController.kecamatanList.value,
                              value: kecamatanValue,
                              isRequired: true,
                              listName: 'name',
                              valueName: 'id',
                              itemCallback: (String value) {
                                kecamatanValue = value;
                                registrationController.fetchKelurahan(value);

                                var kecamatanTempValue = registrationController.kecamatanList.value
                                    .where((element) => element['id'] == value)
                                    .toList();

                                kecamatanStringValue = kecamatanTempValue[0]['name'];
                                kelurahanValue = null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            flex: 1,
                            child: DropdownFieldWidget(
                              title: 'Kelurahan',
                              listValue: registrationController.kelurahanList.value,
                              value: kelurahanValue,
                              isRequired: true,
                              listName: 'name',
                              valueName: 'id',
                              itemCallback: (String value) {
                                kelurahanValue = value;
                                var kelurahanTempValue = registrationController.kelurahanList.value
                                    .where((element) => element['id'] == value)
                                    .toList();

                                kelurahanStringValue = kelurahanTempValue[0]['name'];
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                DropdownFieldWidget(
                  title: 'Apakah Anda mengenal Suheriyatna ?',
                  value: mengenalValue,
                  listValue: mengenalList,
                  valueName: 'status',
                  listName: 'nama',
                  isRequired: true,
                  itemCallback: (String value) {
                    mengenalValue = value;
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () {
                    _onAlertPress();
                  },
                  child: Container(
                    height: 20.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Upload Dokumen Pendukung',
                          style: headTextStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Icon(
                          Remix.image_add_line,
                          color: primaryColor,
                          size: 40.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    padding: EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: 15.h,
                        width: 30.w,
                        child: opsionalImage == null ? null : Image.file(File(opsionalImage!.path)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 2.h,
                ),
                ButtonWidget(
                  color: primaryColor,
                  onTap: () {
                    sharedController
                        .popUpMessage('Konfirmasi', 'Apakah Anda yakin ingin menyimpan kuisioner?', 'Batal', 'Ya', () {
                      Get.back();
                      kuisionerController.addKuisioner(tNamaLengkap.text, jenisKelaminValue, kabupatenStringValue,
                          kecamatanStringValue, kelurahanStringValue, mengenalValue, opsionalImage!, context);
                    }, true, context);
                  },
                  title: 'Kirim',
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
