import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';
import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';

class TextAreaWidget extends StatefulWidget {
  final String? title;
  final String? hint;
  final TextEditingController? tController;
  final Function? onTap;
  final TextInputType? inputType;
  final bool? currency;

  TextAreaWidget({Key? key, this.title, this.hint, this.tController, this.onTap, this.inputType, this.currency})
      : super(key: key);

  @override
  State<TextAreaWidget> createState() => _TextAreaWidgetState();
}

class _TextAreaWidgetState extends State<TextAreaWidget> {
  static const _locale = 'id';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Text(
          widget.title!,
          style: defaultTextStyle.copyWith(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 0.5.h),
        TextField(
          minLines: 6,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: widget.tController,
          onChanged: widget.currency == true
              ? (string) {
                  string = '${_formatNumber(string.replaceAll('.', ''))}';
                  widget.tController?.value = TextEditingValue(
                    text: string,
                    selection: TextSelection.collapsed(offset: string.length),
                  );
                }
              : (string) {
                  print(widget.tController?.value);
                },
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              hintText: widget.hint,
              hintStyle: TextStyle(fontSize: 12.0.sp),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greyColor),
                borderRadius: BorderRadius.circular(6.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greyColor), borderRadius: BorderRadius.circular(6.0))),
        ),
      ],
    );
  }
}
