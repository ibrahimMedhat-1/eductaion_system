import 'package:education_system/auth/login/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/locale/applocale.dart';
import '../../shared/main_cubit/main_cubit.dart';
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
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: GestureDetector(
                    onTap: () {
                      if (MainCubit.get(context).lang == "en") {
                        MainCubit.get(context).changeLang('ar');
                      } else {
                        MainCubit.get(context).changeLang('en');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ColorsAsset.kPrimary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${getLang(context, "EN")}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorsAsset.kPrimary,
                        ),
                      ),
                    ),
                  ),

                ),
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                    height: MediaQuery.of(context).size.height * 0.78,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: Colors.white.withOpacity(0.8)),
                    child: SingleChildScrollView(
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
                            textInputType: TextInputType.emailAddress,
                            controller: cubit.emailController,
                            hintText: '${getLang(context,  "Email")}'
                           ,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MainTextField(
                            obscure: cubit.obscure,
                            suffixPressed: cubit.suffixPressed,
                      
                            suffixIcon: cubit.suffixIcon ,
                            textInputType: TextInputType.text,
                            controller: cubit.passwordController,
                            hintText: '${getLang(context,  "Password")}',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: cubit.isProfessor,
                                      onChanged: (value) {
                                        cubit.changeToProfessor();
                                      }),
                                  const Text(
                                      'Professor'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: cubit.isAdmin,
                                      onChanged: (value) {
                                        cubit.changeToadmin();
                                      }),
                                  const Text('Admin'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: cubit.isParent,
                                      onChanged: (value) {
                                        cubit.changeToParent();
                                      }),
                                  const Text('Parent'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
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
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                                    child: Text(
                      
                                      '${getLang(context,  "Sign In")}',
                                      style: const TextStyle(color: Colors.white),
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
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                      
                                Text(
                                    '${getLang(context,  "Don't Have Account? ")}'
                                   ,
                                    style: const TextStyle(
                                      color: ColorsAsset.kPrimary,
                                    )),
                                Text(
                                  '${getLang(context,  "Create Account")}'
                                  ,
                                  style: const TextStyle(color: ColorsAsset.kTextcolor, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
