import 'package:anjuman_e_najmi/logic/cubit/authentication/auth_cubit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logic/cubit/receipt/receipt_cubit.dart';
import 'landscape_mode.dart';

class Globals {
  static Color themeColor =

      /// const Color(0xff202A44)
      const Color(0xff456BD0);
  static Color kTextFieldFilledColor = const Color(0xffF1F1F1);
  static Color kUniversalColor = themeColor;

  static Color ktitleColor = const Color(0xff5A5A5A);
  static Color kTextFieldBorderColor = const Color(0xffC5C4C4);
  static Color kFiledColor = const Color(
      // 0xffF1F1F1
      0xff9B9595);
  static Color kRedColor = const Color(0xffFF7070);
  static Color kbottomtextColor = const Color(0xff494949);

  static var kUniversal;
  static showToast(var txt) {
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static Future<void> mainInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    Globals.isInternetConnectedListner();
    await Globals.getToken();
  }

  static String connectionStatus = 'Unknown';
  static bool isInternetAvalible = false;
  static String paid = "paid";
  static String unpaid = "unpaid";
  static int limit = 10;
  static int offset = 0;

  static String? token;
  static getToken() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    token = pre.getString('token') ?? "";
    debugPrint("UTils $token");
    if (token != null) {
      return token;
    }
  }

  static Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    } else {
      return false;
    }
  }

  static bool isTextNullOrEmpty(String? text) {
    if (text == null) {
      return true;
    }
    if (text.isEmpty) {
      return true;
    }
    if (text.trim() == "") {
      return true;
    }
    if (text.trim() == "null") {
      return true;
    }
    return false;
  }

  static String isTextNullOrEmptyString(String? text) {
    if (text == null) {
      return "";
    }
    if (text.isEmpty) {
      return "";
    }
    if (text.trim() == "") {
      return "";
    }
    if (text.trim() == "null") {
      return "";
    }
    return text.trim();
  }

  static void isInternetConnectedListner() {
    Connectivity _connectivity = Connectivity();
    initConnectivity(_connectivity);
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  static Future<void> initConnectivity(Connectivity connectivity) async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return _updateConnectionStatus(result);
  }

  static Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        isInternetAvalible = true;
        connectionStatus = result.toString();
        break;
      case ConnectivityResult.mobile:
        isInternetAvalible = true;
        connectionStatus = result.toString();
        break;
      case ConnectivityResult.none:
        isInternetAvalible = false;
        connectionStatus = result.toString();
        break;
      default:
        isInternetAvalible = false;
        connectionStatus = 'Failed to get connectivity.';
        break;
    }
  }

  static receiptpaidDialog(context, Function() confim, Function() cancel) {
    return AlertDialog(
        insetPadding: EdgeInsets.only(
            left: isLandscape(context) ? 90 : 15,
            right: isLandscape(context) ? 90 : 15,
            //  top: isLandscape(context) ? 30 : 160,
            bottom: 0),
        //     const EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 35),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Globals.kTextFieldFilledColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Are you sure you want to paid Receipt?",

              //    "Are you sure you want to ${BlocProvider.of<ReceiptCubit>(context).state.isCheck! ? "Paid" : "Unpaid"} Receipt?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff525252),
                  fontSize: 16),
            ),
            SizedBox(
              height: Globals.getDeviceHeight(context) * 0.04,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Color(0xff456BD0), width: 1.2),
                    gradient: LinearGradient(
                        colors: [Color(0xff233C7E), Color(0xff456BD0)])),
                child: MaterialButton(
                  onPressed: confim,
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xff456BD0), width: 1.2),
                ),
                child: MaterialButton(
                  onPressed: cancel,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Globals.kUniversalColor,
                        fontSize: 16),
                  ),
                ),
              ),
            ]),
          ],
        ));
  }

  static receiptunpaidDialog(context, Function() confim, Function() cancel) {
    return AlertDialog(
        insetPadding: EdgeInsets.only(
            left: isLandscape(context) ? 90 : 15,
            right: isLandscape(context) ? 90 : 15,
            // top: isLandscape(context) ? 30 : 160,
            bottom: 0),
        //     const EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 35),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Globals.kTextFieldFilledColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Are you sure you want to unpaid Receipt?",
              //  ${  BlocProvider.of<ReceiptCubit>(context).state.isCheck! ? "Paid" : "Unpaid"} Receipt?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff525252),
                  fontSize: 16),
            ),
            SizedBox(
              height: Globals.getDeviceHeight(context) * 0.04,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Color(0xff456BD0), width: 1.2),
                    gradient: LinearGradient(
                        colors: [Color(0xff233C7E), Color(0xff456BD0)])),
                child: MaterialButton(
                  onPressed: confim,
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xff456BD0), width: 1.2),
                ),
                child: MaterialButton(
                  onPressed: cancel,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Globals.kUniversalColor,
                        fontSize: 16),
                  ),
                ),
              ),
            ]),
          ],
        ));
  }

  static receiptpaidStatus(BuildContext context) {
    int index = 0;
    return BlocBuilder<ReceiptCubit, ReceiptState>(
      bloc: BlocProvider.of<ReceiptCubit>(context).receiptdetails(),
      builder: (context, state) {
        return SingleChildScrollView(
          child: AlertDialog(
            insetPadding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: isLandscape(context) ? 20 : 100,
                bottom: 0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                    Text("Receipt#${state.receipt![index].id.toString()}",
                        // "Receipt#1245",
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
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    Color(0xff233C7E),
                                    Color(0xff456BD0)
                                  ]),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: Globals.getDeviceHeight(context) * 0.03,
                ),
                receiptDetailtext(
                    context,
                    "Receipt Name:",
                    //"XYZ" receiptType

                    state.receipt![index].receiptNumber.toString()),
                receiptDetailtext(
                    context, "Name:", state.receipt![index].createdOn.toString()
                    // "Shaikh Aliasger Bhai"receiptType name
                    ),
                receiptDetailtext(context, "Mohalla:",
                    state.receipt![index].mohallaId.toString()
                    // "Zainee"
                    ),
                receiptDetailtext(context, "Receipt Date & Time:",
                    state.receipt![index].depositDate.toString()
                    // "10-05-2021 05:10:30"
                    ),
                receiptDetailtext(context, "MOP:",
                    state.receipt![index].paymentMode.toString()
                    //  "Cash"
                    ),
                receiptDetailtext(context, "Amount:",
                    state.receipt![index].hubAmount.toString()
                    //  "150.00"
                    ),
                receiptDetailtext(context, "Receipt Made By:",
                    state.receipt![index].createdBy.toString()
                    // "Mulla Hakimuddin"
                    ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state.accesses?[1].childResources?[2].access == "w" ||
                                  state.accesses?[1].childResources?[2]
                                          .access ==
                                      "r"
                              ? DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(colors: [
                                        Color(0xff233C7E),
                                        Color(0xff456BD0)
                                      ])),
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Globals.receiptunpaidDialog(context,
                                                () {
                                              BlocProvider.of<ReceiptCubit>(
                                                      context)
                                                  .check(true);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            }, () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            })),
                                    child:
                                        BlocBuilder<ReceiptCubit, ReceiptState>(
                                      builder: (context, state) {
                                        return Text(
                                          //     state.isCheck! ?
                                          "Mark Unpaid",
                                          //    "Paid",
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              fontSize: 16),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ]);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static receiptunpaidStatus(BuildContext context) {
    return BlocBuilder<ReceiptCubit, ReceiptState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: AlertDialog(
            insetPadding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: isLandscape(context) ? 20 : 100,
                bottom: 0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                    //1245
                    Text("Receipt#${state.receiptNumber}",
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
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    Color(0xff233C7E),
                                    Color(0xff456BD0)
                                  ]),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: Globals.getDeviceHeight(context) * 0.03,
                ),
                receiptDetailtext(context, "Receipt Name:", "1"
                    //  "XYZ"
                    ),
                receiptDetailtext(context, "Name:", "Shaikh Aliasger Bhai"),
                receiptDetailtext(context, "Mohalla:", "${state.mohallah}"
                    // "Zainee"
                    ),
                receiptDetailtext(
                    context, "Receipt Date & Time:", "${state.dateController}"
                    //  "10-05-2021 05:10:30"
                    ),
                receiptDetailtext(context, "MOP:", "${state.paymentMode}"
                    // "Cash"
                    ),
                receiptDetailtext(context, "Amount:", "${state.amount}"
                    //   "150.00"
                    ),
                receiptDetailtext(
                    context, "Receipt Made By:", "Mulla Hakimuddin"),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state.accesses?[1].childResources?[1].access == "w"
                              ? DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(colors: [
                                        Color(0xff233C7E),
                                        Color(0xff456BD0)
                                      ])),
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Globals.receiptpaidDialog(context,
                                                () {
                                              BlocProvider.of<ReceiptCubit>(
                                                      context)
                                                  .check(true);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            }, () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            })),
                                    child:
                                        BlocBuilder<ReceiptCubit, ReceiptState>(
                                      builder: (context, state) {
                                        return Text(
                                          // state.isCheck! ?
                                          //    "Unpaid",
                                          //    :
                                          "Mark Paid",
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              fontSize: 16),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ]);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static receiptDetailtext(context, String title, String detail) {
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

  static popupDialog(context, Function() yes, Function() no, String text) {
    return AlertDialog(
        insetPadding: EdgeInsets.only(
          left: isLandscape(context) ? 90 : 15,
          right: isLandscape(context) ? 90 : 15,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: Globals.kTextFieldFilledColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff525252),
                  fontSize: 14),
            ),
            SizedBox(
              height: Globals.getDeviceHeight(context) * 0.04,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Color(0xff456BD0), width: 1.2),
                    gradient: LinearGradient(
                        colors: [Color(0xff233C7E), Color(0xff456BD0)])),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: yes,
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xff456BD0), width: 1.2),
                ),
                child: MaterialButton(
                  onPressed: no,
                  child: Text(
                    "No",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Globals.kUniversalColor,
                        fontSize: 16),
                  ),
                ),
              ),
            ]),
          ],
        ));
  }

  static deleteAccount(context, Function() yes, Function() no) {
    return AlertDialog(
        insetPadding: EdgeInsets.only(
          left: isLandscape(context) ? 90 : 15,
          right: isLandscape(context) ? 90 : 15,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: Globals.kTextFieldFilledColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Are you sure you want to Delete Account?",
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff525252),
                  fontSize: 14),
            ),
            SizedBox(
              height: Globals.getDeviceHeight(context) * 0.04,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Color(0xff456BD0), width: 1.2),
                    gradient: LinearGradient(
                        colors: [Color(0xff233C7E), Color(0xff456BD0)])),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: yes,
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xff456BD0), width: 1.2),
                ),
                child: MaterialButton(
                  onPressed: no,
                  child: Text(
                    "No",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Globals.kUniversalColor,
                        fontSize: 16),
                  ),
                ),
              ),
            ]),
          ],
        ));
  }

  static double getDeviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getDeviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
