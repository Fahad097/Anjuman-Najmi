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
    setState(() {
      isLoading = false;
    });
    print("Okay");
  }

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ReceiptCubit>().resetOffSet();
    context.read<ReceiptCubit>().state.receipt!.clear();
    scrollController.addListener(pagination);
    BlocProvider.of<ReceiptCubit>(context).getpaid(Globals.paid, limit: 4);
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
      BlocProvider.of<ReceiptCubit>(context).getpaid(Globals.paid, limit: 4);
    }
  }

  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptCubit, ReceiptState>(
      builder: (context, state) {
        if (state.receipt!.isNotEmpty) {
          return ListView.builder(
              itemCount: state.receipt?.length ?? 0,
              shrinkWrap: true,
              controller: scrollController,
              itemBuilder: (ctx, index) {
                if (index < state.receipt!.length) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => ViewReceiptPaid(
                              index: index,
                              receipt: state.receipt,
                              isDeshboard: false));
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
