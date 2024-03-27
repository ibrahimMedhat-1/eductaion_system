import 'package:education_system/auth/login/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/utils/colors.dart';
import '../register/register_page.dart';
import 'manager/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final LoginCubit cubit = LoginCubit.get(context);
          return Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/1.png"),
                )),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.4,
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
                        MainTextField(
                          controller: cubit.emailController,
                          hintText: "البريد الالكتروني",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MainTextField(
                          controller: cubit.passwordController,
                          hintText: "كلمة السر",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: cubit.isProfessor,
                                onChanged: (value) {
                                  cubit.changeType();
                                }),
                            const Text('Professor'),
                          ],
                        ),
                        state is LoginLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                onPressed: () {
                                  cubit.login(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsAsset.kPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0), // Border radius
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                                  child: Text(
                                    'تسجيل الدخول',
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
                                "قم بانشاء حساب ",
                                style: TextStyle(color: ColorsAsset.kTextcolor, fontWeight: FontWeight.bold),
                              ),
                              Text("ليس لديك حساب ؟ ",
                                  style: TextStyle(
                                    color: ColorsAsset.kPrimary,
                                  )),
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
        },
      ),
    );
  }
}
