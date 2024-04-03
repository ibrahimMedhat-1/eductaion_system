import 'package:education_system/models/course_model.dart';
import 'package:education_system/student/features/payment/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/locale/applocale.dart';
import '../../../shared/utils/colors.dart';
import 'manager/payment_cubit.dart';

class PaymentPage extends StatelessWidget {
  final CourseModel courseModel;
  const PaymentPage({super.key, required this.courseModel});

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
              title:  Text(
                '${getLang(context, "Online Payment")}'
                ,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   Text(
                    '${getLang(context, "Price of registration : ")}'
                   ,
                    style: const TextStyle(color: ColorsAsset.kPrimary, fontWeight: FontWeight.bold),
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
                    labelText: '${getLang(context, "Card Number")}'
                    ,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: cubit.expiryDateController,
                    labelText: '${getLang(context, "Expiry date")}'
                   ,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: cubit.cardHolderNameController,
                    labelText: '${getLang(context, "Name of card holder")}'
                    ,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: cubit.cvvController,
                    labelText: '${getLang(context, "CVV")}',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.submitPayment(context, courseModel);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: ColorsAsset.kPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:  Padding(
                        padding:const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                        child: Text('${getLang(context, "Submit Payment")}',),
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
