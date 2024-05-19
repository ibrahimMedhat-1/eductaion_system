import 'package:education_system/components/locale/applocale.dart';
import 'package:education_system/shared/custom/custom_icons_icons.dart';
import 'package:education_system/shared/utils/colors.dart';
import 'package:education_system/student/features/contact_us/presentation/view/contact_us_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

class ContactUsFooter extends StatelessWidget {
  const ContactUsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: ColorsAsset.kPrimary),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        /// email
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ContactRowWidget(
              onTap: () {
                UrlLauncherPlugin().launch('mailto:educationsystem718@gmail.com');
                // launchUrl(Uri.parse());
              },
              label: 'educationsystem718@gmail.com',
              icon: Icons.email,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactUsView(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsAsset.kLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Border radius
                ),
              ),
              child: Text(
                getLang(context, 'contactUs'),
              ),
            )
          ],
        ),

        /// phone
        ContactRowWidget(
          onTap: () {
            Clipboard.setData(const ClipboardData(text: '01144208358'));
            Fluttertoast.showToast(msg: 'Copied');
          },
          label: '01144208358',
          icon: Icons.phone,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// linkedin
            ContactRowWidget(
              onTap: () {
                UrlLauncherPlugin().launch('https://www.linkedin.com/in/muhamed-abdelkawy-73b549215');
                // launchUrl(Uri.parse('https://www.linkedin.com/in/muhamed-abdelkawy-73b549215'));
              },
              label: 'LinkedIn',
              icon: CustomIcons.linkedin_squared,
            ),

            /// facebook
            ContactRowWidget(
              onTap: () {
                UrlLauncherPlugin()
                    .launch('https://www.facebook.com/profile.php?id=61559738794281&mibextid=ZbWKwL');

                // launchUrl(
                //     Uri.parse('https://www.facebook.com/profile.php?id=61559738794281&mibextid=ZbWKwL'));
              },
              label: 'FaceBook',
              icon: CustomIcons.facebook_squared,
            ),

            /// instgram
            ContactRowWidget(
              onTap: () {
                UrlLauncherPlugin()
                    .launch('https://www.instagram.com/education_system5?igsh=Ymh5ZDIxc3dlNjBz');

                // launchUrl(Uri.parse('https://www.instagram.com/education_system5?igsh=Ymh5ZDIxc3dlNjBz'));
              },
              label: 'instagram',
              icon: CustomIcons.instagram,
            ),

            /// twitter
            ContactRowWidget(
              onTap: () {
                UrlLauncherPlugin().launch('https://x.com/Education_s5?t=6yBToj7dQCCePZFL74lBcA&s=09');

                // launchUrl(Uri.parse('https://x.com/Education_s5?t=6yBToj7dQCCePZFL74lBcA&s=09'));
              },
              label: 'Twitter',
              icon: CustomIcons.twitter_squared,
            ),
          ],
        )
      ]),
    );
  }
}

class ContactRowWidget extends StatelessWidget {
  const ContactRowWidget({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  final VoidCallback onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: ColorsAsset.kLight),
          const SizedBox(width: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
