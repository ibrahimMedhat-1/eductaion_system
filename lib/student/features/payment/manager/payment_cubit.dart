import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/utils/colors.dart';


part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  void submitPayment(BuildContext context) {
    bool isNotEmpty(String value) => value.trim().isNotEmpty;

    if (isNotEmpty(cardNumberController.text) &&
        isNotEmpty(expiryDateController.text) &&
        isNotEmpty(cardHolderNameController.text) &&
        isNotEmpty(cvvController.text)) {

      showDialog(
        context: context,
        builder: (context) => AlertDialog(

          title: const Row(
            children: [
              Text('Success',style: TextStyle(color: Colors.green),),
              Icon(Icons.check,color: Colors.green,)
            ],
          ),
          content: const Text('Payment submitted successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK',style: TextStyle(color: ColorsAsset.kPrimary)),
            ),
          ],
        ),
      );
    } else {

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:  const Row(
            children: [
              Text('Error',style: TextStyle(color: Colors.red),),
              Icon(Icons.close,color: Colors.red,)
            ],
          ),
          content: const Text('Please fill in all fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK',style: TextStyle(color: ColorsAsset.kPrimary)),
            ),
          ],
        ),
      );
    }
  }

}
