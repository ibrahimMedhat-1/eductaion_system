import 'package:flutter/material.dart';

import '../../shared/utils/colors.dart';
import '../login/widgets/main_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/2.png"),
          )),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(left: 50, top: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: Colors.white.withOpacity(0.8)),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/logo2.png",
                          height: 150,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "بيانات الطالب",
                              style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Flexible(
                            child: MainTextField(
                              hintText: "الاسم بالكامل",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: MainTextField(
                              hintText: "رقم الهاتف",
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Flexible(
                            child: MainTextField(
                              hintText: "البريد الالكتروني",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: MainTextField(
                              hintText: "كلمة السر",
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "بيانات ولي الامر",
                              style: TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Flexible(
                            child: MainTextField(
                              hintText: "رقم الهاتف",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: MainTextField(
                              hintText: "البريد الالكتروني",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: MainTextField(
                              hintText: "الاسم",
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsAsset.kPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Border radius
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                            child: Text(
                              'انشاء حساب',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "قم بتسجيل الدخول ",
                                style: TextStyle(color: ColorsAsset.kTextcolor, fontWeight: FontWeight.bold),
                              ),
                              Text("لديك حساب بالفعل؟ ",
                                  style: TextStyle(
                                    color: ColorsAsset.kPrimary,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
