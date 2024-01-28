import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {required this.controller,
      required this.hintText,
      this.obsecureText = false,
      this.suffixIcon,
      this.isSearch = false,
      this.elevation = 1,
      this.onChanged,
      this.suffixIconTap,
      super.key});
  final TextEditingController controller;
  final bool obsecureText;
  final String hintText;
  final IconData? suffixIcon;
  final bool isSearch;
  final double elevation;
  final Function(String)? onChanged;
  final VoidCallback? suffixIconTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: TextField(
            onChanged: onChanged,
            controller: controller,
            obscureText: obsecureText,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                suffixIcon: isSearch
                    ? GestureDetector(
                        onTap: suffixIconTap, child: const Icon(Icons.search))
                    : suffixIcon != null
                        ? GestureDetector(
                            onTap: suffixIconTap, child: Icon(suffixIcon))
                        : null,
                filled: true),
          ),
        ),
      ),
    );
  }
}
