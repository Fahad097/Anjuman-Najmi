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

  double height = 50;
  DateTime now = DateTime.now();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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

      // Load more data using your Cubit.
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
      return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                //  physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 0),
                itemCount: state.receipt!.length,
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: (ctx, i) {
                  if (i < state.receipt!.length + 1) {
                    return InkWell(
                      onTap: () async {
                        context.read<ReceiptCubit>().resetOffSet();
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                ViewReceiptUnPaid(
                                    id: state.receipt?[i].id ?? 0,
                                    fullname: state.receipt?[i].fullname,
                                    amount: state.receipt?[i].hubAmount,
                                    receiptdate: state.receipt?[i].createdOn,
                                    receiptCode: state.receipt?[i].receiptCode,
                                    itsNumber: state.receipt?[i].itsNumber,
                                    hubType: state.receipt?[i].hubType,
                                    paymentMode: state.receipt?[i].paymentMode,
                                    isDeposit: state.receipt?[i].isDeposited));
                      },
                      child: Card(
                        shadowColor: Globals.kUniversalColor,
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                                    "#${state.receipt?[i].receiptCode}"
                                        .toString(),
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
                                    child: Text(
                                        state.receipt?[i].fullname ?? "",
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
                    return Center(
                        child: Text("Please wait data is Loading...."));
                  }
                }),
      );
    });
  }
}

Widget verificationotpDialog(BuildContext context) {
  return SingleChildScrollView(
    child: AlertDialog(
      insetPadding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 125,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      shadowColor: Globals.kTextFieldFilledColor,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: Globals.getDeviceHeight(context) * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Receipt#1245",
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Color(0xff525252),
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  )),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Globals.kUniversalColor),
                        // gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //     colors: <Color>[
                        //       Color(0xff233C7E),
                        //       Color(0xff456BD0)
                        //     ]),
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.close,
                      color: Globals.kUniversalColor,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: Globals.getDeviceHeight(context) * 0.03,
          ),
          rowtText(context, "Receipt Name:", "XYZ"),
          rowtText(context, "Name:", "Shaikh Aliasger Bhai"),
          rowtText(context, "Mohalla:", "Zainee"),
          rowtText(context, "Receipt Date & Time:", "10-05-2021 05:10:30"),
          rowtText(context, "MOP:", "Cash"),
          rowtText(context, "Amount:", "150.00"),
          rowtText(context, "Receipt Made By:", "Mulla Hakimuddin"),
          Row(children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [Color(0xff233C7E), Color(0xff456BD0)])),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),

                // color: Globals.kUniversalColor,
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        Globals.receiptpaidDialog(context, () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        })),
                child: Text(
                  "Paid",
                  style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
            Spacer(),
            DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [Color(0xff233C7E), Color(0xff456BD0)])),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        Globals.receiptunpaidDialog(context, () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        })),
                child: Text(
                  "Unpaid",
                  style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
          ]),
        ],
      ),
    ),
  );
}

Widget rowtText(context, String title, String detail) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Globals.getDeviceWidth(context) * 0.31,
            child: Text(title,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  color: Color(0xff676767),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
          SizedBox(
            width: Globals.getDeviceWidth(context) * 0.41,
            child: Text(detail,
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  color: Globals.kUniversalColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
        ],
      ),
      SizedBox(
        height: Globals.getDeviceHeight(context) * 0.02,
      )
    ],
  );
}
