import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/colors.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/fonts.dart';
import 'package:suheriyatna_mobile/presentation/koordinator/controllers/koordinator.controller.dart';
import 'package:suheriyatna_mobile/presentation/notifikasi/notifikasi.screen.dart';
import 'package:suheriyatna_mobile/presentation/registration/controllers/registration.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/controllers/shared.controller.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/button_widget.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/dropdown_field_widget.dart';
import 'package:suheriyatna_mobile/presentation/shared/widget/input_field_widget.dart';

class AddKoordinatorScreen extends StatefulWidget {
  const AddKoordinatorScreen({Key? key}) : super(key: key);

  @override
  State<AddKoordinatorScreen> createState() => _AddKoordinatorScreenState();
}

class _AddKoordinatorScreenState extends State<AddKoordinatorScreen> {
  KoordinatorController koordinatorController = Get.put(KoordinatorController());
  RegistrationController registrationController = Get.put(RegistrationController());
  SharedController sharedController = Get.put(SharedController());

  TextEditingController tNIK = TextEditingController();
  TextEditingController tNamaLengkap = TextEditingController();
  TextEditingController tKataSandi = TextEditingController();
  TextEditingController tKataSandiConfirm = TextEditingController();
  TextEditingController tNoTelp = TextEditingController();

  var kabupatenValue;

  var wilayahKerjaValue;
  var wilayahKerjaStringValue;
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
                          Text('Tambah Koordinator', style: headTextStyle.copyWith(color: whiteColor)),
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
                                  koordinatorController.checkNIKValidasi(tNIK.text, true);
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
                                  koordinatorController.checkTeleponValidasi(tNoTelp.text, true);
                                },
                              )),
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
                      SizedBox(
                        height: 2.h,
                      ),
                      ButtonWidget(
                        color: primaryColor,
                        onTap: () {
                          var nik = tNIK.text == null ? '' : tNIK.text;
                          var namaLengkap = tNamaLengkap.text == null ? '' : tNamaLengkap.text;

                          var noTelp = tNoTelp.text == null ? '' : tNoTelp.text;
                          if (tKataSandi.text != tKataSandiConfirm.text) {
                            sharedController.showSnackbar('Gagal', 'Kata sandi tidak sama');
                            return;
                          } else {
                            if (nik == '' ||
                                namaLengkap == '' ||
                                noTelp == '' ||
                                wilayahKerjaStringValue == null ||
                                tKataSandi.text == '' ||
                                tKataSandiConfirm.text == '') {
                              sharedController.showSnackbar('Gagal', 'Silahkan isi data yang memiliki simbol (*)');
                            } else {
                              if (nik.length == 16) {
                                koordinatorController.registrasiKoordinator(
                                    nik, namaLengkap, noTelp, wilayahKerjaStringValue, tKataSandi.text, context);
                              } else {
                                sharedController.showSnackbar('Gagal', 'NIK harus terdiri dari 16 digit');
                              }
                            }
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
