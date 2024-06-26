import 'package:education_system/auth/login/login%20page.dart';
import 'package:education_system/auth/register/manager/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/locale/applocale.dart';
import '../../shared/constants.dart';
import '../../shared/utils/colors.dart';
import '../login/widgets/main_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final SignUpCubit cubit = SignUpCubit.get(context);
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
                body: Form(
                  key: formKey,
                  child: Padding(
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
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withOpacity(0.8)),
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
                                   Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${getLang(context,  "Student Data")}'
                                        ,
                                        style:
                                            const TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: [
                                    Flexible(
                                      child: MainTextField(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp('[a-z A-Z ا-ي]'))
                                        ],
                                        textInputType: TextInputType.text,
                                        controller: cubit.fullNameController,
                                        hintText: '${getLang(context,  "Full Name")}'
                                        ,
                                        validationText: 'Please insert name',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: MainTextField(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                        ],
                                        textInputType: TextInputType.phone,
                                        controller: cubit.phoneController,
                                        hintText: '${getLang(context,  "Phone No.")}'
                                       ,
                                        validationText: 'Please insert phone',
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: [
                                    Flexible(
                                      child: MainTextField(
                                        textInputType: TextInputType.emailAddress,
                                        controller: cubit.emailController,
                                        hintText: '${getLang(context,  "Email")}',
                                        validationText: 'Please insert email',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: MainTextField(
                                        textInputType: TextInputType.text,
                                        controller: cubit.passwordController,
                                        hintText: '${getLang(context,  "Password")}',
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                   Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${getLang(context,  "Parent Data")}',
                                        style:
                                            const TextStyle(fontWeight: FontWeight.bold, color: ColorsAsset.kPrimary),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(children: [
                                    Flexible(
                                      child: MainTextField(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                        ],
                                        onChanged: (value) {
                                          if (!isNumber(value)) {
                                            cubit.parentPhoneController.clear();
                                            cubit.emit(CheckIsNubmer());
                                          }
                                        },
                                        textInputType: TextInputType.phone,
                                        hintText: '${getLang(context,  "Phone No.")}',
                                        controller: cubit.parentPhoneController,
                                        validationText: 'Please insert phone',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: MainTextField(
                                        textInputType: TextInputType.emailAddress,
                                        controller: cubit.parentEmailController,
                                        hintText: '${getLang(context,  "Email")}',
                                        validationText: 'Please insert email',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: MainTextField(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp('[a-z A-Z ا-ي]'))
                                        ],
                                        textInputType: TextInputType.name,
                                        controller: cubit.parentNameController,
                                        hintText: '${getLang(context,  "Name")}',
                                        validationText: 'Please insert name',
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  state is SignUpLoading
                                      ? const Center(child: CircularProgressIndicator())
                                      : ElevatedButton(
                                          onPressed: () {
                                            if (formKey.currentState!.validate()) {
                                              if (cubit.emailController.text.contains('@') &&
                                                  cubit.parentEmailController.text.contains('@')) {
                                                cubit.signUp(context);
                                              } else {
                                                Fluttertoast.showToast(msg: 'Please insert valid emails');
                                              }
                                            }
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
                                              '${getLang(context,  "Create Account")}'
                                              ,
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
                                        builder: (context) => const LoginPage(),
                                      ));
                                    },
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                              
                                        Text(
                                            '${getLang(context,  "Aready Have Account? ")}'
                                           ,
                                            style: const TextStyle(
                                              color: ColorsAsset.kPrimary,
                                            )),
                                        Text(
                                          '${getLang(context,  "Sign In")}'
                                          ,
                                          style: const TextStyle(
                                              color: ColorsAsset.kTextcolor, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
