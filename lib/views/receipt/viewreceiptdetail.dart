import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/receipt/receipt_cubit.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';

class ViewreceiptDetail extends StatelessWidget {
  const ViewreceiptDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffF5F5F5),
        title: Text("Receipt Details",
            style: TextStyle(
              fontFamily: 'Helvetica',
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            )),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Color(0xffF5F5F5),
      body: BlocBuilder<ReceiptCubit, ReceiptState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 5),
                              //   child: Text("Receipt Details",
                              //       style: TextStyle(  fontFamily: 'Helvetica',
                              //         color: Colors.black,
                              //         fontSize: 22,
                              //         fontWeight: FontWeight.w400,
                              //       )),
                              // ),
                              SizedBox(
                                //10
                                height: Globals.getDeviceHeight(context) * 0.02,
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  width: Globals.getDeviceWidth(context),
                                  height: isLandscape(context)
                                      ? Globals.getDeviceHeight(context)
                                      : Globals.getDeviceHeight(context) * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(children: [
                                          Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                                color: Globals.kUniversalColor),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Text("Receipt#1245",
                                                style: TextStyle(
                                                  fontFamily: 'Helvetica',
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                        ]),
                                        // SizedBox(
                                        //   height:
                                        //       Globals.getDeviceHeight(context) *
                                        //           0.03,
                                        // ),
                                        Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            children: [
                                              viewReceiptRowtext(context,
                                                  "Receipt Name:", "XYZ"),
                                              viewReceiptRowtext(
                                                  context,
                                                  "Name:",
                                                  "Shaikh Aliasger Bhai"),
                                              viewReceiptRowtext(context,
                                                  "Mohalla:", "Zainee"),
                                              viewReceiptRowtext(
                                                  context,
                                                  "Receipt Date & Time:",
                                                  "10-05-2021 05:10:30"),
                                              viewReceiptRowtext(
                                                  context, "MOP:", "Cash"),
                                              viewReceiptRowtext(
                                                  context, "Amount:", "150.00"),
                                              viewReceiptRowtext(
                                                  context,
                                                  "Receipt Made By:",
                                                  "Mulla Hakimuddin")
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              )
                            ]),
                        SizedBox(
                          height: Globals.getDeviceHeight(context) * 0.02,
                        ),
                        MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minWidth: double.infinity,
                          color: Globals.kUniversalColor,
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    receiptDialog(context));
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Paid",
                            style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: Globals.getDeviceHeight(context) * 0.02,
                        ),
                        MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minWidth: double.infinity,
                          color: Globals.kUniversalColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Unpaid",
                            style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                      ]),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget receiptDialog(context) {
    return AlertDialog(
        insetPadding:
            const EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 35),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: Globals.kTextFieldFilledColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Are you sure",
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 22),
            ),
            Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 16),
            ),
            SizedBox(
              height: Globals.getDeviceHeight(context) * 0.02,
            ),
            MaterialButton(
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              minWidth: double.infinity,
              color: Globals.kUniversalColor,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Paid",
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel",
                  style: TextStyle(
                      fontFamily: 'Helvetica',
                      color: Color(0xff9E9D9D),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline)),
            ),
          ],
        ));
  }

  Widget viewReceiptRowtext(context, String title, String detail) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Globals.getDeviceWidth(context) * 0.35,
              child: Text(title,
                  maxLines: 4,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Color(0xff6D6D6D),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            SizedBox(
              width: Globals.getDeviceWidth(context) * 0.45,
              child: Text(detail,
                  maxLines: 4,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Color(0xff124666),
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
}
