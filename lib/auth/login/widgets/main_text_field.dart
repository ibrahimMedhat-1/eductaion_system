import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/utils/colors.dart';

class MainTextField extends StatelessWidget {
  MainTextField({
    super.key,
    this.labeltext,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onSubmitted,
    this.onChanged,
    this.validationText,
    this.suffixPressed,
    required this.textInputType,
    this.inputFormatters,
    this.maxLength,
    this.enabled = true,
    this.onTap,
    this.obscure=false,
  });
  final List<TextInputFormatter>? inputFormatters;
  final bool obscure;
  final String? labeltext;
  final String? validationText;
  final String? hintText;
  final TextEditingController? controller;
  void Function(String)? onSubmitted;
  void Function(String)? onChanged;
  Function()? suffixPressed;
  Widget? prefixIcon;
  IconData? suffixIcon;
  TextInputType textInputType;
  final int? maxLength;
  final bool enabled;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TextFormField(
        obscureText: obscure,
        enabled: enabled,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        controller: controller,
        onFieldSubmitted: onSubmitted,
        keyboardType: textInputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationText;
          }
          return null;
        },
        decoration: InputDecoration(

          suffixIcon: suffixIcon == null
              ? null
              : IconButton(
            onPressed: () {
              suffixPressed!();
            },
            icon: Icon(
              suffixIcon,
              color: Colors.grey,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          labelText: labeltext,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsAsset.kPrimary),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsAsset.kPrimary),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsAsset.kPrimary),
          ),
        ),
      ),
    );
  }
}
