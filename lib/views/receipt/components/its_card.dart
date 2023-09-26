import 'package:anjuman_e_najmi/data/model/its_response.dart';
import 'package:anjuman_e_najmi/logic/cubit/receipt/receipt_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCard extends StatefulWidget {
  final int itsNumber;

  const MyCard({super.key, required this.itsNumber});
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool isLoading = false; // State to track if image is loading
  ItsResponse its = ItsResponse();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptCubit, ReceiptState>(
      builder: (context, state) {
        return Card(
          child: ListTile(
            leading: SizedBox(
                width: 60,
                height: 60,
                child: Image.network("${state.imageUrl ?? ""}")),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.name ?? "",
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  widget.itsNumber.toString(),
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            subtitle: Text(
              state.mohallah ?? "",
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}
