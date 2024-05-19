import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/utils/colors.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    super.key,
    this.labelText,
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
    this.obscure = false,
    this.minLines,
  });

  final List<TextInputFormatter>? inputFormatters;
  final bool obscure;
  final String? labelText;
  final String? validationText;
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final Function()? suffixPressed;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType textInputType;
  final int? maxLength;
  final bool enabled;
  final VoidCallback? onTap;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: obscure
          ? TextFormField(
              obscureText: obscure,
              enabled: enabled,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              onChanged: onChanged,
              controller: controller,
              onFieldSubmitted: onSubmitted,
              keyboardType: textInputType,
              validator: (String? value) {
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
                labelText: labelText,
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 12),
                border: const OutlineInputBorder(borderSide: BorderSide(color: ColorsAsset.kPrimary)),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: ColorsAsset.kPrimary)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: ColorsAsset.kPrimary)),
              ),
            )
          : TextFormField(
              minLines: minLines,
              maxLines: minLines,
              enabled: enabled,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              onChanged: onChanged,
              controller: controller,
              onFieldSubmitted: onSubmitted,
              keyboardType: textInputType,
              validator: (String? value) {
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
                labelText: labelText,
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 12),
                border: const OutlineInputBorder(borderSide: BorderSide(color: ColorsAsset.kPrimary)),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: ColorsAsset.kPrimary)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: ColorsAsset.kPrimary)),
              ),
            ),
    );
  }
}
