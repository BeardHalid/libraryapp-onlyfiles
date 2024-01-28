import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:libraryapp/screenTools/screenTools.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String> items;
  final String hint;
  final Function(dynamic)? onChanged;
  final double? width;
  String? initialValue;
  CustomDropDownButton(
      {required this.items,
      required this.hint,
      this.onChanged,
      this.width,
      this.initialValue,
      super.key});
  @override
  State<CustomDropDownButton> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          value: widget.initialValue,
          onChanged: widget.onChanged,
          hint: CustomText(
            text: widget.hint,
            fontSize: 16,
          ),
          items: widget.items
              .map<DropdownMenuItem>((item) =>
                  DropdownMenuItem(value: item, child: CustomText(text: item)))
              .toList(),
          buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              width: widget.width ?? screenWidth(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey.shade300)),
          dropdownStyleData: DropdownStyleData(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
              isOverButton: false),
        ),
      ),
    );
  }
}
