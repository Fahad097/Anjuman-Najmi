import 'package:anjuman_e_najmi/logic/cubit/receipt/receipt_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZabihatCount extends StatelessWidget {
  final int isZabihat;

  ZabihatCount({super.key, required this.isZabihat});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptCubit, ReceiptState>(
      builder: (context, state) {
        return TextFormField(
            initialValue: isZabihat.toString(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(
              fontFamily: 'Helvetica',
              color: Color(0xff6D6D6D),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            focusNode: _dateFocusNode,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Zabihat Count is required';
              }
              if (value.trim().length > 15) {
                return 'Dont Exceed the text Limit';
              }
              return null;
            },
            // onChanged: (value) => value.isNotEmpty &&
            //         value != '' &&
            //         value.trim().length <= 15
            //     ? context.read<ReceiptCubit>().zabihatCount(int.parse(value))
            //     : print("$value"),
            onChanged: (newValue) {
              int count =
                  int.tryParse(newValue) ?? 0; // Parse the input as an integer
              context
                  .read<ReceiptCubit>()
                  .zabihatCount(count); // Update the state
            },
            decoration: InputDecoration(
                hintText: 'Zabihat Count',
                hintStyle: TextStyle(
                  fontFamily: 'Helvetica',
                  color: Color(0xff6D6D6D),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )));
      },
    );
  }
}

final FocusNode _dateFocusNode = FocusNode();
