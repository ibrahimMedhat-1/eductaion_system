import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';

class QuestionTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String hintText;
  final TextEditingController controller;

  const QuestionTextField({
    super.key,
    this.onChanged,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
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
          onChanged: onChanged),
    );
  }
}
