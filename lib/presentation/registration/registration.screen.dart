// ignore_for_file: sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/registration/registration_complete.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/text_area_field_widget.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../login/login.screen.dart';
import '../shared/widget/button_widget.dart';
import '../shared/widget/custom_textfield_widget.dart';
import '../shared/widget/dropdown_field_widget.dart';
import '../shared/widget/input_field_widget.dart';
import 'controllers/registration.controller.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  RegistrationController registrationController = Get.put(RegistrationController());
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
  TextEditingController tKataSandi = TextEditingController();
  TextEditingController tKataSandiConfirm = TextEditingController();
  TextEditingController tNoTelp = TextEditingController();

  var jenisKelaminValue;
  var kabupatenValue;
  var wilayahKerjaValue;
  var wilayahKerjaStringValue;
  var kecamatanValue;
  var kabupatenStringValue;
  var kecamatanStringValue;
  var kelurahanStringValue;
  var kelurahanValue;
  var agamaValue;
  var golDarahValue;
  var statusPernikahanValue;
  var roleValue;

  var jenisKelaminList = [
    {'nama': 'Laki-laki', 'status': 'laki-laki'},
    {'nama': 'Perempuan', 'status': 'perempuan'},
  ];
  var roleList = [
    {'name': 'Relawan', 'id': '1'},
    {'name': 'DTDC', 'id': '2'},
    {'name': 'Quick Count', 'id': '3'},
  ];
  var agamaList = [
    {'nama': 'Islam', 'status': 'Islam'},
    {'nama': 'Kristen', 'status': 'Kristen'},
    {'nama': 'Hindu', 'status': 'Hindu'},
    {'nama': 'Budha', 'status': 'Budha'},
  ];
  var statusPernikahanList = [
    {'nama': 'Belum Menikah', 'status': 'Belum Menikah'},
    {'nama': 'Sudah Menikah', 'status': 'Sudah Menikah'},
    {'nama': 'Janda', 'status': 'Janda'},
    {'nama': 'Duda', 'status': 'Duda'},
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
  var kecamatanList = [];
  var kelurahanList = [];
  var kabupatenList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text('Selamat datang di Suheriyatna Mobile',
                  style: headTextStyle.copyWith(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 14.sp)),
              SizedBox(height: 2.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                // height: 80.h,
                width: 100.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Daftar',
                        style:
                            headTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold, color: secondaryColor),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      DropdownFieldWidget(
                        title: 'Daftar Sebagai ?',
                        listValue: roleList,
                        value: roleValue,
                        isRequired: true,
                        listName: 'name',
                        valueName: 'id',
                        itemCallback: (String value) {
                          roleValue = value;
                        },
                      ),
                      InputFieldWidget(
                        inputType: TextInputType.number,
                        title: 'NIK',
                        tController: tNIK,
                        isRequired: true,
                      ),
                      InputFieldWidget(
                        title: 'Nama Lengkap',
                        tController: tNamaLengkap,
                        isRequired: true,
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
                        title: 'Alamat',
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: InputFieldWidget(
                              title: 'Nomor Telepon',
                              isRequired: true,
                              tController: tNoTelp,
                            ),
                          ),
                        ],
                      ),
                      InputFieldWidget(
                        tController: tKodeReferral,
                        title: 'Kode Referal',
                      ),
                      InputFieldWidget(
                        tController: tKataSandi,
                        title: 'Kata Sandi',
                        isRequired: true,
                        isObscure: true,
                      ),
                      InputFieldWidget(
                        tController: tKataSandiConfirm,
                        title: 'Konfirmasi Kata Sandi',
                        isRequired: true,
                        isObscure: true,
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
                      SizedBox(
                        height: 2.h,
                      ),
                      ButtonWidget(
                        color: secondaryColor,
                        title: 'Daftar',
                        onTap: () {
                          var nik = tNIK.text == null ? '' : tNIK.text;
                          var namaLengkap = tNamaLengkap.text == null ? '' : tNamaLengkap.text;
                          var tempatLahir = tTempatLahir.text == null ? '' : tTempatLahir.text;
                          var tanggalLahir = tTanggalLahir.text == null ? '' : tTanggalLahir.text;

                          var alamat = tAlamat.text == null ? '' : tAlamat.text;
                          var rw = tRW.text == null ? '' : tRW.text;
                          var rt = tRT.text == null ? '' : tRT.text;

                          var kodeReferral = tKodeReferral.text == null ? '' : tKodeReferral.text;
                          var noTelp = tNoTelp.text == null ? '' : tNoTelp.text;
                          if (tKataSandi.text != tKataSandiConfirm.text) {
                            sharedController.showSnackbar('Gagal', 'Kata sandi tidak sama');
                            return;
                          } else {
                            if (roleValue == null ||
                                nik == '' ||
                                namaLengkap == '' ||
                                jenisKelaminValue == null ||
                                tempatLahir == '' ||
                                tanggalLahir == '' ||
                                kabupatenStringValue == null ||
                                kecamatanStringValue == null ||
                                kelurahanStringValue == null ||
                                alamat == '' ||
                                rt == '' ||
                                rw == '' ||
                                noTelp == '' ||
                                wilayahKerjaStringValue == null) {
                              sharedController.showSnackbar('Gagal', 'Silahkan isi data yang memiliki simbol (*)');
                            } else {
                              if (nik.length == 16) {
                                registrationController.registrasiUser(
                                    roleValue,
                                    nik,
                                    namaLengkap,
                                    jenisKelaminValue,
                                    tempatLahir,
                                    tanggalLahir,
                                    kabupatenStringValue,
                                    kecamatanStringValue,
                                    kelurahanStringValue,
                                    alamat,
                                    rt,
                                    rw,
                                    kodeReferral,
                                    noTelp,
                                    wilayahKerjaStringValue,
                                    tKataSandi.text,
                                    context);
                              } else {
                                sharedController.showSnackbar('Gagal', 'NIK harus terdiri dari 16 digit');
                              }
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Divider(
                                thickness: 2,
                              )),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            ' atau ',
                            style: defaultTextStyle,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                              flex: 1,
                              child: Divider(
                                thickness: 2,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah memiliki akun ?',
                            style: defaultTextStyle,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(LoginScreen());
                            },
                            child: Text(
                              ' Login Sekarang ',
                              style: defaultTextStyle.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
