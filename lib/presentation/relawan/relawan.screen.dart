import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/screens.dart';

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
  int activeStep = 0;

  int upperBound = 2;
  var agamaValue;
  var jenisKelaminValue;
  var agamaList = [
    {'nama': 'Islam', 'status': 'Islam'},
    {'nama': 'Kristen', 'status': 'Kristen'},
    {'nama': 'Hindu', 'status': 'Hindu'},
    {'nama': 'Budha', 'status': 'Budha'},
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
                      SizedBox(height: 2.h),
                      NumberStepper(
                          stepRadius: 20,
                          activeStepColor: secondaryColor,
                          enableNextPreviousButtons: false,
                          numberStyle: TextStyle(color: whiteColor, fontSize: 20.sp),
                          enableStepTapping: false,
                          previousButtonIcon: Icon(Remix.arrow_left_s_line),
                          activeStep: activeStep,

                          // This ensures step-tapping updates the activeStep.
                          onStepReached: (index) {
                            setState(() {
                              activeStep = index;
                            });
                          },
                          numbers: [1, 2, 3]),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        headerText(),
                        style: headTextStyle.copyWith(fontWeight: FontWeight.bold, color: whiteColor, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                content()!,
              ],
            )),
      ),
    );
  }

  Widget? content() {
    switch (activeStep) {
      case 1:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextAreaWidget(
                title: 'Alamat Lengkap',
              ),
              InputFieldWidget(
                title: 'RT/RW',
              ),
              DropdownFieldWidget(
                title: 'Kecamatan',
              ),
              DropdownFieldWidget(
                title: 'Kelurahan/Desa',
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: ButtonWidget(
                      color: Colors.yellow[900],
                      onTap: () {
                        if (activeStep > 0) {
                          setState(() {
                            activeStep--;
                          });
                        }
                      },
                      title: 'Sebelumnya',
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Flexible(
                    flex: 1,
                    child: ButtonWidget(
                      color: primaryColor,
                      onTap: () {
                        if (activeStep < upperBound) {
                          setState(() {
                            activeStep++;
                          });
                        }
                      },
                      title: 'Lanjut',
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      case 2:
        return Container(
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
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: ButtonWidget(
                      color: Colors.yellow[900],
                      onTap: () {
                        if (activeStep > 0) {
                          setState(() {
                            activeStep--;
                          });
                        }
                      },
                      title: 'Sebelumnya',
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Flexible(
                    flex: 1,
                    child: ButtonWidget(
                      color: primaryColor,
                      onTap: () {
                        if (activeStep < upperBound) {
                          setState(() {
                            activeStep++;
                          });
                        }
                      },
                      title: 'Lanjut',
                    ),
                  ),
                ],
              )
            ],
          ),
        );

      default:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputFieldWidget(
                title: 'NIK',
              ),
              InputFieldWidget(
                title: 'Nama Lengkap',
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
              InputFieldWidget(
                title: 'Tempat Lahir',
              ),
              InputFieldWidget(
                title: 'Tanggal Lahir',
              ),
              DropdownFieldWidget(
                title: 'Agama',
                listValue: agamaList,
                value: agamaValue,
                valueName: 'status',
                listName: 'nama',
                itemCallback: (String value) {
                  agamaValue = value;
                },
              ),
              InputFieldWidget(
                title: 'Pekerjaan',
              ),
              SizedBox(
                height: 2.h,
              ),
              ButtonWidget(
                color: primaryColor,
                onTap: () {
                  if (activeStep < upperBound) {
                    setState(() {
                      activeStep++;
                    });
                  }
                },
                title: 'Lanjut',
              )
            ],
          ),
        );
    }
  }

  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Alamat Relawan';

      case 2:
        return 'Dokumen Pendukung Relawan';

      default:
        return 'Identitas Relawan';
    }
  }
}
