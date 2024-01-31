import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

import 'package:get/get.dart';
// import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/main.dart';
import 'package:suheriyatna_mobile/presentation/registration/controllers/registration.controller.dart';
import 'package:suheriyatna_mobile/presentation/screens.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../shared/widget/button_widget.dart';
import '../shared/widget/dropdown_field_widget.dart';
import '../shared/widget/input_field_widget.dart';
import '../shared/widget/text_area_field_widget.dart';
import 'controllers/relawan.controller.dart';

class RelawanScreen extends StatefulWidget {
  const RelawanScreen({Key? key}) : super(key: key);

  @override
  State<RelawanScreen> createState() => _RelawanScreenState();
}

class _RelawanScreenState extends State<RelawanScreen> {
  RegistrationController registrationController = Get.put(RegistrationController());
  RelawanController relawanController = Get.put(RelawanController());
  SharedController sharedController = Get.put(SharedController());
  TextEditingController tNIK = TextEditingController();
  TextEditingController tNamaLengkap = TextEditingController();
  TextEditingController tTempatLahir = TextEditingController();
  TextEditingController tTanggalLahir = TextEditingController();
  TextEditingController tGolDarah = TextEditingController();
  TextEditingController tAlamat = TextEditingController();
  TextEditingController tRT = TextEditingController();
  TextEditingController tRW = TextEditingController();
  TextEditingController tPekerjaan = TextEditingController();
  TextEditingController tEmail = TextEditingController();
  TextEditingController tKodeReferral = TextEditingController();
  TextEditingController tNoTelp = TextEditingController();
  TextEditingController tTPS = TextEditingController();
  int activeStep = 0;

  int upperBound = 2;
  var agamaValue;
  var jenisKelaminValue;
  var kabupatenValue;
  var kecamatanValue;
  var kabupatenStringValue;
  var kecamatanStringValue;
  var kelurahanStringValue;
  var kelurahanValue;
  var golDarahValue;
  var wilayahKerjaValue;
  var wilayahKerjaStringValue;
  var agamaList = [
    {'nama': 'Islam', 'status': 'Islam'},
    {'nama': 'Kristen', 'status': 'Kristen'},
    {'nama': 'Hindu', 'status': 'Hindu'},
    {'nama': 'Budha', 'status': 'Budha'},
  ];

  var golDarahList = [
    {'nama': 'A', 'status': 'A'},
    {'nama': 'B', 'status': 'B'},
    {'nama': 'AB', 'status': 'AB'},
    {'nama': 'O', 'status': 'O'},
    {'nama': 'A+', 'status': 'A+'},
    {'nama': 'A-', 'status': 'A-'},
    {'nama': 'B+', 'status': 'B+'},
    {'nama': 'B-', 'status': 'B-'},
    {'nama': 'AB+', 'status': 'AB+'},
    {'nama': 'AB-', 'status': 'AB-'},
    {'nama': 'O+', 'status': 'O+'},
    {'nama': 'O-', 'status': 'O-'},
  ];
  var jenisKelaminList = [
    {'nama': 'Laki-laki', 'status': 'laki-laki'},
    {'nama': 'Perempuan', 'status': 'perempuan'},
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
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text('Tambah Relawan', style: headTextStyle.copyWith(color: whiteColor)),
                          GestureDetector(
                            onTap: () => Get.to(() => NotifikasiScreen()),
                            child: Icon(
                              Remix.notification_3_line,
                              color: whiteColor,
                            ),
                          )
                        ],
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            flex: 2,
                            child: InputFieldWidget(
                              title: 'NIK',
                              isRequired: true,
                              tController: tNIK,
                              inputType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Flexible(
                              flex: 1,
                              child: ButtonWidget(
                                color: primaryColor,
                                title: 'Cek',
                                onTap: () {
                                  relawanController.checkNIKValidasi(tNIK.text);
                                },
                              )),
                        ],
                      ),
                      InputFieldWidget(
                        title: 'Nama Lengkap',
                        tController: tNamaLengkap,
                        isRequired: true,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            flex: 2,
                            child: InputFieldWidget(
                              title: 'Nomor Telepon',
                              isRequired: true,
                              tController: tNoTelp,
                              inputType: TextInputType.phone,
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Flexible(
                              flex: 1,
                              child: ButtonWidget(
                                color: primaryColor,
                                title: 'Cek',
                                onTap: () {
                                  relawanController.checkTeleponValidasi(tNoTelp.text);
                                },
                              )),
                        ],
                      ),
                      DropdownFieldWidget(
                        title: 'Jenis Kelamin',
                        value: jenisKelaminValue,
                        listValue: jenisKelaminList,
                        isRequired: true,
                        valueName: 'status',
                        listName: 'nama',
                        itemCallback: (String value) {
                          jenisKelaminValue = value;
                        },
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: InputFieldWidget(
                              title: 'Tempat Lahir',
                              tController: tTempatLahir,
                              isRequired: true,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            flex: 1,
                            child: InputFieldWidget(
                              title: 'Tanggal Lahir',
                              tController: tTanggalLahir,
                              isRequired: true,
                              onTap: () async {
                                DateTime? newDateTime = await showRoundedDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 100),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  borderRadius: 16,
                                );

                                tTanggalLahir.text =
                                    DateFormat('dd-MM-yyy').format(DateTime.parse(newDateTime.toString())).toString();
                              },
                            ),
                          ),
                        ],
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
                      TextAreaWidget(
                        title: 'Alamat Lengkap',
                        isRequired: true,
                        tController: tAlamat,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: InputFieldWidget(
                              title: 'RT',
                              tController: tRT,
                              isRequired: true,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            flex: 1,
                            child: InputFieldWidget(
                              title: 'RW',
                              tController: tRW,
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                      Obx(() => Container(
                            width: double.infinity,
                            child: DropdownFieldWidget(
                              title: 'Wilayah Kerja',
                              listValue: registrationController.kabupatenList.value,
                              value: kabupatenValue,
                              isRequired: true,
                              listName: 'name',
                              valueName: 'id',
                              itemCallback: (String value) {
                                wilayahKerjaValue = value;
                                var wilayahKerjaempValue = registrationController.kabupatenList.value
                                    .where((element) => element['id'] == value)
                                    .toList();

                                wilayahKerjaStringValue = wilayahKerjaempValue[0]['name'];
                              },
                            ),
                          )),
                      InputFieldWidget(
                        title: 'TPS',
                        tController: tTPS,
                        isRequired: true,
                        inputType: TextInputType.number,
                      ),
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
                      ButtonWidget(
                        color: primaryColor,
                        onTap: () {
                          var nik = tNIK.text == null ? '' : tNIK.text;
                          var namaLengkap = tNamaLengkap.text == null ? '' : tNamaLengkap.text;
                          var tempatLahir = tTempatLahir.text == null ? '' : tTempatLahir.text;
                          var tanggalLahir = tTanggalLahir.text == null ? '' : tTanggalLahir.text;

                          var alamat = tAlamat.text == null ? '' : tAlamat.text;
                          var rt = tRT.text == null ? '' : tRT.text;
                          var rw = tRW.text == null ? '' : tRW.text;
                          var pekerjaan = tPekerjaan.text == null ? '' : tPekerjaan.text;
                          var email = tEmail.text == null ? '' : tEmail.text;
                          var tps = tTPS.text == null ? '' : tTPS.text;

                          var noTelp = tNoTelp.text == null ? '' : tNoTelp.text;
                          if (opsionalImage == null) {
                            sharedController.showSnackbar('Gagal', 'Upload dokumen pendukung tidak boleh kosong');
                          } else {
                            sharedController.popUpMessage(
                                'Konfirmasi', 'Apakah Anda yakin ingin menambahkan relawan?', 'Batal', 'Ya', () {
                              Get.back();
                              sharedController.loading(context);

                              relawanController.addRelawan(
                                  nik,
                                  namaLengkap,
                                  noTelp,
                                  jenisKelaminValue,
                                  tempatLahir,
                                  tanggalLahir,
                                  kabupatenStringValue,
                                  kecamatanStringValue,
                                  kelurahanStringValue,
                                  alamat,
                                  rt,
                                  rw,
                                  wilayahKerjaStringValue,
                                  tps,
                                  opsionalImage!,
                                  false,
                                  context);
                            }, true, context);
                          }
                        },
                        title: 'Kirim',
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
