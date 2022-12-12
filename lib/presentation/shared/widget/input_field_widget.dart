import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';
import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';

class InputFieldWidget extends StatefulWidget {
  final String? title;
  final String? hint;
  final TextEditingController? tController;
  final Function? onTap;
  final TextInputType? inputType;
  final bool? currency;
  final bool? isRequired;

  InputFieldWidget(
      {Key? key, this.title, this.hint, this.tController, this.onTap, this.inputType, this.currency, this.isRequired})
      : super(key: key);

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  static const _locale = 'id';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Row(
          children: [
            Text(
              widget.title!,
              style: defaultTextStyle.copyWith(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 1.w),
            widget.isRequired == null
                ? SizedBox()
                : Text(
                    '*',
                    style: defaultTextStyle.copyWith(fontSize: 12.0.sp, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
          ],
        ),
        SizedBox(height: 0.5.h),
        TextField(
          minLines: 1,
          maxLines: 2,
          keyboardType: widget.inputType != null ? widget.inputType : null,
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
