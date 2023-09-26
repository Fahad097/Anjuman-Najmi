import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/receipt/receipt_cubit.dart';
import '../../utils/global_constants.dart';
import 'components/viewReceiptpaid.dart';

class Paid extends StatefulWidget {
  const Paid({Key? key}) : super(key: key);

  @override
  _PaidState createState() => _PaidState();
}

class _PaidState extends State<Paid> {
  bool isLoading = false;
  refres() async {
    BlocProvider.of<ReceiptCubit>(context).getpaid(limit: 4, Globals.paid);
    // BlocProvider.of<ReceiptCubit>(context).getReceiptAllPaid();
    setState(() {
      isLoading = false;
    });
    print("Okay");
  }

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(pagination);
    BlocProvider.of<ReceiptCubit>(context).getpaid(Globals.unpaid, limit: 4);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void pagination() async {
    if (!isLoading &&
        scrollController.position.maxScrollExtent - scrollController.offset <=
            200.0) {
      setState(() {
        isLoading = true;
      });

      await BlocProvider.of<ReceiptCubit>(context).updateOffSet();
      BlocProvider.of<ReceiptCubit>(context).getpaid(Globals.unpaid, limit: 4);

      // setState(() {
      //   isLoading = false;
      //   // Check if there's more data to load.
      //   hasMoreData = // Add your condition to check if there's more data.
      // });
    }
  }

  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptCubit, ReceiptState>(
      builder: (context, state) {
        if (state.receipt!.isNotEmpty) {
          return ListView.builder(
              itemCount: state.receipt!.length + 1,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                if (index < state.receipt!.length) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => ViewReceiptPaid(
                              id: state.receipt?[index].id ?? 0,
                              fullname: state.receipt?[index].fullname,
                              amount: state.receipt?[index].hubAmount,
                              receiptdate: state.receipt?[index].createdOn,
                              receiptCode: state.receipt?[index].receiptCode,
                              itsNumber: state.receipt?[index].itsNumber,
                              hubType: state.receipt?[index].hubType,
                              paymentMode: state.receipt?[index].paymentMode,
                              isDeposit: state.receipt?[index].isDeposited));
                    },
                    child: Card(
                      shadowColor: Globals.kUniversalColor,
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "#${state.receipt![index].receiptCode}",
                                  //  "#1245",
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w400,
                                      color: Globals.kUniversalColor,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text(
                                    "Date:${state.receipt![index].depositDate.toString()}",
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff889EC9),
                                        fontSize: 12)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                      "${state.receipt![index].fullname.toString()}",
                                      style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff858585),
                                          fontSize: 16)),
                                ),
                                Spacer(),
                                Text(
                                  "Time:${state.receipt![index].createdOn.toString()}",
                                  style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff889EC9),
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  if (state.isCheck!) {
                    return Center(
                      widthFactor: 10,
                      heightFactor: 10,
                      child: Center(
                        child: CircularProgressIndicator(
                            color: Globals.kUniversalColor),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 10,
                      width: 10,
                      child: Center(
                        child: Text(
                          "No More Receipts",
                        ),
                      ),
                    );
                  }
                }
              });
        } else {
          return Center(
              child: CircularProgressIndicator(color: Globals.kUniversalColor));
        }
      },
    );
  }
}
