import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:libraryapp/screenTools/screenTools.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool obsecureText;
  final String hintText;
  final bool showPasswordIcon;
  final bool enabled;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;

  const CustomTextFormField(
      {required this.controller,
      required this.hintText,
      this.obsecureText = false,
      this.showPasswordIcon = false,
      this.enabled = true,
      this.keyboardType,
      this.onTap,
      super.key});

  @override
  State<CustomTextFormField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context),
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Material(
          borderRadius: BorderRadius.circular(16.0),
          elevation: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.obsecureText,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  hintText: widget.hintText,
                  suffixIcon: widget.showPasswordIcon
                      ? IconButton(
                          icon: const Icon(Icons.remove_red_eye_rounded),
                          onPressed: widget.onTap,
                        )
                      : null),
              enabled: widget.enabled,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bu alan boş burakılamaz!';
                } else if (widget.keyboardType == TextInputType.number &&
                    !value.contains(RegExp(r'[0-9]'))) {
                  return 'Lütfen sayısal değer giriniz!';
                } else if (widget.keyboardType == TextInputType.text &&
                    !value.contains(RegExp(r'[A-Z]'))) {
                  return 'Lütfen metinsel değer giriniz!';
                }
                return null;
              },
              onChanged: (value) => {
                setState(
                  () {
                    widget.controller.text = value;
                    log(value);
                  },
                )
              },
            ),
          ),
        ),
      ),
    );
  }
}
