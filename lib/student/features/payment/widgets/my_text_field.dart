import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.labelText,
    this.controller,
    this.prefixIcon,
    this.hintText,
    this.onSubmitted,
    this.onChanged,
    this.flex = 1,
  });

  final int flex;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
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
