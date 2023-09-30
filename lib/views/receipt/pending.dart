import 'package:anjuman_e_najmi/views/receipt/components/viewrecceiptunpaid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/receipt/receipt_cubit.dart';
import '../../utils/global_constants.dart';

class Pending extends StatefulWidget {
  const Pending({Key? key}) : super(key: key);

  @override
  _PendingState createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  bool isLoading = false;

  refres() async {
    setState(() {
      isLoading = false;
      context.read<ReceiptCubit>().resetOffSet();
      context.read<ReceiptCubit>().state.receipt!.clear();
    });
    print("Okay");
  }

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ReceiptCubit>().resetOffSet();
    context.read<ReceiptCubit>().state.receipt!.clear();
    // Initialize your scroll controller and listen for scroll events.
    scrollController.addListener(pagination);
    // Load initial data.
    BlocProvider.of<ReceiptCubit>(context).getpaid(Globals.unpaid, limit: 4);
  }

  @override
  void dispose() {
    // Dispose of your scroll controller when the widget is disposed.
    scrollController.dispose();
    super.dispose();
  }

  void pagination() async {
    // Check if the user has scrolled to the end of the list with a threshold value.
    if (!isLoading &&
        scrollController.position.maxScrollExtent - scrollController.offset <=
            200.0) {
      setState(() {
        isLoading = true; // Show loading indicator.
      });

      await BlocProvider.of<ReceiptCubit>(context).updateOffSet();
      BlocProvider.of<ReceiptCubit>(context).getpaid(Globals.unpaid, limit: 4);

      setState(() {
        isLoading = false; // Hide loading indicator.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptCubit, ReceiptState>(builder: (context, state) {
      if (state.receipt!.isNotEmpty) {
        return ListView.builder(
            //  physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 0),
            itemCount: state.receipt?.length ?? 0,
            shrinkWrap: true,
            controller: scrollController,
            itemBuilder: (ctx, i) {
              if (i < state.receipt!.length) {
                return InkWell(
                  onTap: () async {
                    //   context.read<ReceiptCubit>().resetOffSet();
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) => ViewReceiptUnPaid(
                              index: i,
                              receipt: state.receipt,
                              isDeshboard: false,
                            ));
                  },
                  child: Card(
                    shadowColor: Globals.kUniversalColor,
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                                // "#1245",
                                "#${state.receipt?[i].receiptCode}".toString(),
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w400,
                                    color: Globals.kUniversalColor,
                                    fontSize: 15),
                              ),
                              Spacer(),
                              Text(
                                  "Date:${state.receipt?[i].depositDate.toString()

                                  /// convertdate
                                  }",
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
                                child: Text(state.receipt?[i].fullname ?? "",
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff858585),
                                        fontSize: 16)),
                              ),
                              Spacer(),
                              Text(
                                "Time:${state.receipt?[i].createdOn.toString()}",
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
                return Center(child: Text("Please wait data is Loading...."));
              }
            });
      } else {
        return Center(
            child: CircularProgressIndicator(color: Globals.kUniversalColor));
      }
    });
  }
}
