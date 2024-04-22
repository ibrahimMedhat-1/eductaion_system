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
    required this.textInputType,
    this.inputFormatters,
    this.maxLength,
    this.enabled = true,
    this.onTap,
  });
  final List<TextInputFormatter>? inputFormatters;

  final String? labeltext;
  final String? validationText;
  final String? hintText;
  final TextEditingController? controller;
  void Function(String)? onSubmitted;
  void Function(String)? onChanged;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType textInputType;
  final int? maxLength;
  final bool enabled;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TextFormField(
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
