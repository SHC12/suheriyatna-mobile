import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';
import '../../../infrastructure/theme/colors.dart';
import '../../../infrastructure/theme/fonts.dart';

class DropdownFieldWidget extends StatefulWidget {
  final String? title;

  String? value;
  final List? listValue;

  DropdownFieldWidget({Key? key, this.title, this.value, this.listValue}) : super(key: key);

  @override
  State<DropdownFieldWidget> createState() => _DropdownFieldWidgetState();
}

class _DropdownFieldWidgetState extends State<DropdownFieldWidget> {
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
        Container(
          width: 100.w,
          height: 6.h,
          padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 1.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: greyColor),
          ),
          child: DropdownButton(
            isExpanded: true,
            underline: SizedBox(),
            hint: Text("Pilih"),
            value: widget.value,
            items: widget.listValue?.map((value) {
              return DropdownMenuItem(
                child: Text(value['nama'], style: defaultTextStyle.copyWith(fontSize: 12)),
                value: value['status'],
              );
            }).toList(),
            onChanged: (v) {
              setState(() {
                print(v);
                widget.value = v.toString();
              });
            },
          ),
        ),
      ],
    );
  }
}
