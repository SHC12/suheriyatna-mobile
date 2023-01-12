import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:suheriyatna_mobile/presentation/profil/controllers/profil.controller.dart';
import 'package:suheriyatna_mobile/presentation/profil/profil.screen.dart';

import '../../infrastructure/theme/colors.dart';
import '../../infrastructure/theme/fonts.dart';
import '../login/login.screen.dart';
import '../shared/controllers/shared.controller.dart';
import '../shared/widget/button_widget.dart';
import '../shared/widget/dropdown_field_widget.dart';
import '../shared/widget/header_widget.dart';
import '../shared/widget/input_field_widget.dart';
import '../shared/widget/text_area_field_widget.dart';

class UpdateDataScreen extends StatefulWidget {
  final List? dataSaya;
  const UpdateDataScreen({Key? key, this.dataSaya}) : super(key: key);

  @override
  State<UpdateDataScreen> createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  ProfilController profilController = Get.put(ProfilController());
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

  var kecamatanList = [];
  var kelurahanList = [];
  var kabupatenList = [];

  final ImagePicker _picker = ImagePicker();

  bool isChangePhoto = false;

  XFile? opsionalImage;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tNIK.text = widget.dataSaya![0]['nik'];
    tNamaLengkap.text = widget.dataSaya![0]['nama_lengkap'];
    tTempatLahir.text = widget.dataSaya![0]['tempat_lahir'];
    tTanggalLahir.text = widget.dataSaya![0]['tanggal_lahir'];

    tAlamat.text = widget.dataSaya![0]['alamat'];
    tRT.text = widget.dataSaya![0]['rt'];
    tRW.text = widget.dataSaya![0]['rw'];

    tNoTelp.text = widget.dataSaya![0]['no_telp'];
    jenisKelaminValue = widget.dataSaya![0]['jenis_kelamin'];
    List kabupatenID = sharedController.kabupatenList
        .where((element) => element['name'].toString() == widget.dataSaya![0]['kabupaten'])
        .toList();
    List wilkerID = sharedController.kabupatenList
        .where((element) => element['name'].toString() == widget.dataSaya![0]['wilayah_kerja'])
        .toList();
    List kecamatanID = sharedController.kecamatanList
        .where((element) => element['name'].toString() == widget.dataSaya![0]['kecamatan'])
        .toList();
    List kelurahanID = sharedController.kelurahanList
        .where((element) => element['name'].toString() == widget.dataSaya![0]['kelurahan'])
        .toList();
    print('kab id : ${kabupatenID[0]['id']}');
    print('kec id : ${kecamatanID[0]['id']}');
    print('kel id : ${kelurahanID[0]['id']}');
    kabupatenValue = kabupatenID[0]['id'];
    kecamatanValue = kecamatanID[0]['id'];
    kelurahanValue = kelurahanID[0]['id'];
    wilayahKerjaValue = wilkerID[0]['id'];
    kabupatenStringValue = kabupatenID[0]['name'];
    kecamatanStringValue = kecamatanID[0]['name'];
    kelurahanStringValue = kelurahanID[0]['name'];
    wilayahKerjaStringValue = wilkerID[0]['name'];
  }

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
          HeaderWidget(
            isHome: false,
            title: 'Ubah Data',
            isBack: true,
            onTap: () {
              Get.to(() => ProfilScreen());
            },
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: 100.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  InputFieldWidget(
                    isReadOnly: true,
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
                          listValue: sharedController.kabupatenList.value,
                          value: kabupatenValue,
                          isRequired: true,
                          listName: 'name',
                          valueName: 'id',
                          itemCallback: (String value) {
                            kabupatenValue = value;
                            sharedController.fetchKecamatan(value);
                            var kabupatenTempValue = sharedController.kabupatenList.value
                                .where((element) => element['id'] == value)
                                .toList();

                            kabupatenStringValue = kabupatenTempValue[0]['name'];
                            kecamatanValue = null;
                            kecamatanStringValue = null;
                            kelurahanStringValue = null;
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
                                listValue: sharedController.kecamatanList.value,
                                value: kecamatanValue,
                                isRequired: true,
                                listName: 'name',
                                valueName: 'id',
                                itemCallback: (String value) {
                                  kecamatanValue = value;
                                  sharedController.fetchKelurahan(value);

                                  var kecamatanTempValue = sharedController.kecamatanList.value
                                      .where((element) => element['id'] == value)
                                      .toList();

                                  kecamatanStringValue = kecamatanTempValue[0]['name'];
                                  kelurahanValue = null;
                                  kelurahanStringValue = null;
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
                                listValue: sharedController.kelurahanList.value,
                                value: kelurahanValue,
                                isRequired: true,
                                listName: 'name',
                                valueName: 'id',
                                itemCallback: (String value) {
                                  kelurahanValue = value;
                                  var kelurahanTempValue = sharedController.kelurahanList.value
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
                          isReadOnly: true,
                          tController: tNoTelp,
                        ),
                      ),
                    ],
                  ),
                  Obx(() => Container(
                        width: double.infinity,
                        child: DropdownFieldWidget(
                          title: 'Wilayah Kerja',
                          listValue: sharedController.kabupatenList.value,
                          value: kabupatenValue,
                          isRequired: true,
                          listName: 'name',
                          valueName: 'id',
                          itemCallback: (String value) {
                            wilayahKerjaValue = value;
                            var wilayahKerjaempValue = sharedController.kabupatenList.value
                                .where((element) => element['id'] == value)
                                .toList();

                            wilayahKerjaStringValue = wilayahKerjaempValue[0]['name'];
                          },
                        ),
                      )),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Upload Foto Profil',
                                style: headTextStyle.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                '*',
                                style: defaultTextStyle.copyWith(
                                    fontSize: 12.0.sp, fontWeight: FontWeight.bold, color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
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
                    height: 1.h,
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
                          child: opsionalImage == null
                              ? Image.network(widget.dataSaya![0]['file_pendukung'])
                              : Image.file(File(opsionalImage!.path)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ButtonWidget(
                    color: secondaryColor,
                    title: 'Simpan Data',
                    onTap: () {
                      print(opsionalImage);
                      print(kabupatenStringValue);
                      print(kecamatanStringValue);
                      print(kelurahanStringValue);
                      print(wilayahKerjaStringValue);

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
                        if (kabupatenStringValue == null ||
                            kecamatanStringValue == null ||
                            kelurahanStringValue == null ||
                            wilayahKerjaStringValue == null) {
                          sharedController.showSnackbar(
                              'Gagal', 'Silahkan isi data kabupaten, kecamatan, kelurahan dan wilayah kerja');
                        } else {
                          profilController.updateData(
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
                              wilayahKerjaStringValue,
                              opsionalImage);
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
