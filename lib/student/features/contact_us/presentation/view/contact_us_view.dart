import 'package:education_system/auth/login/widgets/main_text_field.dart';
import 'package:email_sender/email_sender.dart';
import 'package:flutter/material.dart';

import '../../../../../components/locale/applocale.dart';
import '../../../../../shared/utils/colors.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Row(
              children: [
                Expanded(
                  child: MainTextField(
                    textInputType: TextInputType.name,
                    hintText: 'Name',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MainTextField(
                    textInputType: TextInputType.name,
                    hintText: 'Phone',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Expanded(
                  child: MainTextField(
                    textInputType: TextInputType.name,
                    hintText: 'Email',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: MainTextField(
                    textInputType: TextInputType.name,
                    hintText: 'Subject',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Expanded(
                  child: MainTextField(
                    minLines: 6,
                    textInputType: TextInputType.name,
                    hintText: 'Letter',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                EmailSender emailSender = EmailSender();
                var response = await emailSender.sendMessage('doha.kroz0@gmail.com', "Education System",
                    'Education System Password', 'Your Password is 123456');
                debugPrint(response);
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
