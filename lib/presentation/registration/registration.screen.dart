// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/registration/registration_complete.screen.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../login/login.screen.dart';
import '../shared/widget/button_widget.dart';
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
  TextEditingController tRTRW = TextEditingController();
  TextEditingController tPekerjaan = TextEditingController();
  TextEditingController tEmail = TextEditingController();
  TextEditingController tKodeReferral = TextEditingController();
  TextEditingController tNoTelp = TextEditingController();

  var jenisKelaminValue;
  var kabupatenValue;
  var kecamatanValue;
  var kabupatenStringValue;
  var kecamatanStringValue;
  var kelurahanStringValue;
  var kelurahanValue;
  var agamaValue;
  var golDarahValue;
  var statusPernikahanValue;

  var jenisKelaminList = [
    {'nama': 'Laki-laki', 'status': 'laki-laki'},
    {'nama': 'Perempuan', 'status': 'perempuan'},
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
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: DropdownFieldWidget(
                              title: 'Jenis Kelamin',
                              listValue: jenisKelaminList,
                              isRequired: true,
                              value: jenisKelaminValue,
                              listName: 'nama',
                              valueName: 'status',
                              itemCallback: (String value) {
                                jenisKelaminValue = value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            flex: 1,
                            child: DropdownFieldWidget(
                              title: 'Gol. Darah',
                              listValue: golDarahList,
                              value: golDarahValue,
                              isRequired: true,
                              listName: 'nama',
                              valueName: 'status',
                              itemCallback: (String value) {
                                golDarahValue = value;
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
                      Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: InputFieldWidget(
                              title: 'Alamat',
                              tController: tAlamat,
                              isRequired: true,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            flex: 1,
                            child: InputFieldWidget(
                              title: 'RT/RW',
                              tController: tRTRW,
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      InputFieldWidget(
                        title: 'Pekerjaan',
                        tController: tPekerjaan,
                        isRequired: true,
                      ),
                      InputFieldWidget(
                        title: 'Email',
                        tController: tEmail,
                      ),
                      InputFieldWidget(
                        tController: tKodeReferral,
                        title: 'Kode Referal',
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
                          var rtRw = tRTRW.text == null ? '' : tRTRW.text;
                          var pekerjaan = tPekerjaan.text == null ? '' : tPekerjaan.text;
                          var email = tEmail.text == null ? '' : tEmail.text;
                          var kodeReferral = tKodeReferral.text == null ? '' : tKodeReferral.text;
                          var noTelp = tNoTelp.text == null ? '' : tNoTelp.text;

                          Map a = {
                            'nik': nik,
                            'nama_lengkap': namaLengkap,
                            'tempat_lahir': tempatLahir,
                            'tanggal_lahir': tanggalLahir,
                            'jenis_kelamin': jenisKelaminValue,
                            'gol_darah': golDarahValue,
                            'kabupaten': kabupatenStringValue,
                            'kecamatan': kecamatanStringValue,
                            'kelurahan': kelurahanStringValue,
                            'alamat': alamat,
                            'rt_rw': rtRw,
                            'pekerjaan': pekerjaan,
                            'email': email,
                            'kode_referral': kodeReferral,
                            'no_telp': noTelp,
                          };
                          print(a);

                          if (nik == '' ||
                              namaLengkap == '' ||
                              tempatLahir == '' ||
                              tanggalLahir == '' ||
                              jenisKelaminValue == null ||
                              golDarahValue == null ||
                              kabupatenStringValue == null ||
                              kecamatanStringValue == null ||
                              kelurahanStringValue == null ||
                              alamat == '' ||
                              rtRw == '' ||
                              pekerjaan == '' ||
                              noTelp == '') {
                            sharedController.showSnackbar('Gagal', 'Silahkan isi data yang memiliki simbol (*)');
                          } else {
                            registrationController.registrasiRelawan(
                                nik,
                                namaLengkap,
                                tempatLahir,
                                tanggalLahir,
                                jenisKelaminValue,
                                golDarahValue,
                                kabupatenStringValue,
                                kecamatanStringValue,
                                kelurahanStringValue,
                                alamat,
                                rtRw,
                                pekerjaan,
                                email,
                                kodeReferral,
                                noTelp,
                                context);
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
