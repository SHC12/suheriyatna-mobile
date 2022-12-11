// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/registration/registration_complete.screen.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../login/login.screen.dart';
import '../shared/widget/button_widget.dart';
import '../shared/widget/dropdown_field_widget.dart';
import '../shared/widget/input_field_widget.dart';
import 'controllers/registration.controller.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  RegistrationController registrationController = Get.put(RegistrationController());

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
  var kelurahanValue;
  var agamaValue;
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
              Text('Selamat datang di Suheriyatna Mobile',
                  style: headTextStyle.copyWith(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 14.sp)),
              SizedBox(height: 2.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 80.h,
                width: 100.w,
                child: SingleChildScrollView(
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
                          style: headTextStyle.copyWith(
                              fontSize: 14.sp, fontWeight: FontWeight.bold, color: secondaryColor),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        InputFieldWidget(
                          title: 'NIK',
                          tController: tNIK,
                        ),
                        InputFieldWidget(
                          title: 'Nama Lengkap',
                          tController: tNamaLengkap,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: InputFieldWidget(
                                title: 'Tempat Lahir',
                                tController: tTempatLahir,
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
                              child: InputFieldWidget(
                                title: 'Gol. Darah',
                                tController: tGolDarah,
                              ),
                            ),
                          ],
                        ),
                        Obx(() => Container(
                              width: double.infinity,
                              child: Flexible(
                                flex: 1,
                                child: DropdownFieldWidget(
                                  title: 'Kabupaten',
                                  listValue: registrationController.kabupatenList.value,
                                  value: kabupatenValue,
                                  listName: 'name',
                                  valueName: 'id',
                                  itemCallback: (String value) {
                                    kabupatenValue = value;
                                    registrationController.fetchKecamatan(value);
                                    kecamatanValue = null;
                                    kelurahanValue = null;
                                  },
                                ),
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
                                      listName: 'name',
                                      valueName: 'id',
                                      itemCallback: (String value) {
                                        kecamatanValue = value;
                                        registrationController.fetchKelurahan(value);
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
                                      listName: 'name',
                                      valueName: 'id',
                                      itemCallback: (String value) {
                                        kelurahanValue = value;
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
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Flexible(
                        //       flex: 1,
                        //       child: DropdownFieldWidget(
                        //         title: 'Agama',
                        //         listValue: agamaList,
                        //         value: agamaValue,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 2.w,
                        //     ),
                        //     Flexible(
                        //       flex: 1,
                        //       child: DropdownFieldWidget(
                        //         title: 'Status Pernikahan',
                        //         listValue: statusPernikahanList,
                        //         value: statusPernikahanValue,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 2.h,
                        ),
                        InputFieldWidget(
                          title: 'Pekerjaan',
                          tController: tPekerjaan,
                        ),
                        InputFieldWidget(
                          title: 'Email',
                          tController: tEmail,
                        ),
                        // InputFieldWidget(
                        //   title: 'Password',
                        // ),
                        // InputFieldWidget(
                        //   title: 'Konfirmasi Password',
                        // ),
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
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Flexible(
                                flex: 1,
                                child: ButtonWidget(
                                  color: primaryColor,
                                  title: 'OTP',
                                  onTap: () {},
                                ))
                          ],
                        ),
                        InputFieldWidget(
                          title: 'Kode OTP',
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        ButtonWidget(
                          color: secondaryColor,
                          title: 'Daftar',
                          onTap: () {
                            registrationController.registrasiRelawan(
                                tNIK.text,
                                tNamaLengkap.text,
                                tTempatLahir.text,
                                tTanggalLahir.text,
                                jenisKelaminValue,
                                tGolDarah.text,
                                kabupatenValue,
                                kecamatanValue,
                                kelurahanValue,
                                tAlamat.text,
                                tRTRW.text,
                                tPekerjaan.text,
                                tEmail.text,
                                tKodeReferral.text,
                                tNoTelp.text);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
