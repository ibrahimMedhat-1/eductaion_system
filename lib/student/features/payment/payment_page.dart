import 'package:education_system/auth/login/widgets/main_text_field.dart';
import 'package:education_system/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/locale/applocale.dart';
import '../../../shared/utils/colors.dart';
import 'manager/payment_cubit.dart';

class PaymentPage extends StatelessWidget {
  final CourseModel courseModel;

  const PaymentPage({super.key, required this.courseModel});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {},
        builder: (context, state) {
          PaymentCubit cubit = PaymentCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                '${getLang(context, "Online Payment")}',
                style: const TextStyle(color: ColorsAsset.kPrimary),
              ),
              backgroundColor: ColorsAsset.kLight2,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset("assets/images/logo2.png"),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${getLang(context, "Price of registration : ")}',
                      style: const TextStyle(color: ColorsAsset.kPrimary, fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/compngwingyobdm-fotor-bg-remover-202312293115.png',
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MainTextField(
                      controller: cubit.cardNumberController,
                      hintText: '${getLang(context, "Card Number")}',
                      textInputType: TextInputType.phone,
                      validationText: 'Please insert your card number',
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MainTextField(
                      enabled: false,
                      onTap: () async {
                        var date = await showDatePicker(
                          firstDate: DateTime(1, 1, 1),
                          lastDate: DateTime.now(),
                          context: context,
                          onDatePickerModeChange: (value) {
                            print(value);
                          },
                        );

                        print(date);
                        cubit.expiryDateController.text =
                            '${date.toString().split(' ').first.split('-').first}/${date.toString().split(' ').first.split('-')[1]}';
                        cubit.emit(PaymentInitial());
                      },
                      controller: cubit.expiryDateController,
                      hintText: '${getLang(context, "Expiry date")}',
                      textInputType: TextInputType.datetime,
                      validationText: 'Please insert your exp date',
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MainTextField(
                      controller: cubit.cardHolderNameController,
                      hintText: '${getLang(context, "Name of card holder")}',
                      textInputType: TextInputType.name,
                      validationText: 'Please insert card holder name',
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MainTextField(
                      maxLength: 3,
                      controller: cubit.cvvController,
                      hintText: '${getLang(context, "CVV")}',
                      textInputType: TextInputType.number,
                      validationText: 'Please insert your CVV',
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.submitPayment(context, courseModel);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: ColorsAsset.kPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                          child: Text(
                            '${getLang(context, "Submit Payment")}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
