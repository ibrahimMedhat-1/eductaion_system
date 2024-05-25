import 'dart:convert';

import 'package:education_system/auth/login/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../../../components/locale/applocale.dart';
import '../../../../../shared/utils/colors.dart';

class ContactUsView extends StatelessWidget {
  ContactUsView({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController cvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: MainTextField(
                    controller: nameController,
                    textInputType: TextInputType.name,
                    hintText: 'Name',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MainTextField(
                    controller: phoneController,
                    textInputType: TextInputType.name,
                    hintText: 'Phone',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: MainTextField(
                    controller: emailController,
                    textInputType: TextInputType.name,
                    hintText: 'Email',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MainTextField(
                    controller: subjectController,
                    textInputType: TextInputType.name,
                    hintText: 'Subject',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: MainTextField(
                    controller: cvController,
                    minLines: 6,
                    textInputType: TextInputType.name,
                    hintText: 'CV',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                var response = await http.post(
                  Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
                  headers: {
                    'Content-Type': "application/json",
                  },
                  body: json.encode({
                    'service_id': "service_hz76xfb",
                    'template_id': "template_1ro0yvz",
                    'user_id': "2QByaSzIidfViDpTb",
                    'template_params': {
                      'from_name': nameController.text,
                      'from_email': emailController.text,
                      'from_number': phoneController.text,
                      'from_subject': subjectController.text,
                      'from_cv': cvController.text,
                      'reply_to': 'educationsystem718@gmail.com',
                      'to_email': 'educationsystem718@gmail.com',
                    },
                  }),
                );
                Fluttertoast.showToast(msg: 'Email Sent');
                Navigator.pop(context);
                print(response.body);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ColorsAsset.kPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: Text('${getLang(context, "Send")}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
