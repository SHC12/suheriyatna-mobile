import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:suheriyatna_mobile/infrastructure/theme/colors.dart';

import 'controllers/pengumuman.controller.dart';

class PengumumanScreen extends StatefulWidget {
  const PengumumanScreen({Key? key}) : super(key: key);

  @override
  State<PengumumanScreen> createState() => _PengumumanScreenState();
}

class _PengumumanScreenState extends State<PengumumanScreen> {
  bool _isLoading = true;
  PDFDocument? document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/images/cv3.pdf');

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Profil Dr. Ir. H. Suheriyatna, M.Si.'),
        centerTitle: true,
      ),
      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document!,
                  lazyLoad: false,
                  zoomSteps: 1,
                  numberPickerConfirmWidget: const Text(
                    "Confirm",
                  ),
                )),
    );
  }
}
