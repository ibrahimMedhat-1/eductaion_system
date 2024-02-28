import 'package:eductaion_system/student/features/payment/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/utils/colors.dart';
import 'manager/payment_cubit.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {},
        builder: (context, state) {
          PaymentCubit cubit = PaymentCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'الدفع الالكتروني',
                style: TextStyle(color: ColorsAsset.kPrimary),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "قيمة الاشتراك : 2500",
                    style: TextStyle(color: ColorsAsset.kPrimary, fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/compngwingyobdm-fotor-bg-remover-202312293115.png',
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: cubit.cardNumberController,
                    labelText: 'رقم البطاقة',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: cubit.expiryDateController,
                    labelText: 'تاريخ الانتهاء',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: cubit.cardHolderNameController,
                    labelText: 'اسم حامل البطاقة',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: cubit.cvvController,
                    labelText: "CVV",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.submitPayment(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: ColorsAsset.kPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                        child: Text('اتمام الدفع'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
