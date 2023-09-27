import 'package:anjuman_e_najmi/data/model/permission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/authentication/auth_cubit.dart';
import '../../../logic/cubit/receipt/receipt_cubit.dart';
import '../../../utils/global_constants.dart';
import '../../../utils/landscape_mode.dart';
import '../edit_receipt.dart';

class ViewReceiptUnPaid extends StatefulWidget {
  ViewReceiptUnPaid({
    super.key,
    this.id,
    this.fullname,
    this.isDeposit,
    this.amount,
    this.receiptdate,
    this.receiptCode,
    this.hubType,
    this.itsNumber,
    this.paymentMode,
    this.isDeshboard,
  });
  final int? id;
  final String? fullname;

  final String? receiptdate;

  final String? amount;

  final String? receiptCode;
  final int? isDeposit;
  final int? hubType;

  final int? paymentMode;

  final int? itsNumber;
  final bool? isDeshboard;

  @override
  State<ViewReceiptUnPaid> createState() => _ViewReceiptUnPaidState();
}

class _ViewReceiptUnPaidState extends State<ViewReceiptUnPaid> {
  @override
  void initState() {
    // BlocProvider.of<ReceiptCubit>(context).getReceipt(widget.id ?? 0);
    super.initState();
  }

  int i = 0;
  var hasWriteDashboard =
      permissionService.hasWritePermission('app.dashboard.receipt');
  var hasWrite = permissionService.hasWritePermission('app.receipt');
  var hasWritePaid = permissionService.hasWritePermission('app.receipt.paid');
  Widget build(BuildContext context) {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
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
                    if (widget.isDeshboard == true)
                      if (hasWriteDashboard)
                        IconButton(
                            onPressed: () {
                              //  context.read<ReceiptCubit>().lastReceiptNumber();
                              context.read<ReceiptCubit>().getPayment();
                              context.read<ReceiptCubit>().getHubType();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => EditReceipt(
                                            receitId: widget.id,
                                            fullname: widget.fullname,
                                            amount: widget.amount,
                                            receiptdate: widget.receiptdate,
                                            receiptCode: widget.receiptCode,
                                            hubType: widget.hubType,
                                            paymentMode: widget.paymentMode,
                                            itsNumber: widget.itsNumber,
                                          )));
                            },
                            icon: Icon(Icons.edit)),
                    if (widget.isDeshboard == false)
                      if (hasWrite)
                        IconButton(
                            onPressed: () {
                              //  context.read<ReceiptCubit>().lastReceiptNumber();
                              context.read<ReceiptCubit>().getPayment();
                              context.read<ReceiptCubit>().getHubType();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => EditReceipt(
                                            receitId: widget.id,
                                            fullname: widget.fullname,
                                            amount: widget.amount,
                                            receiptdate: widget.receiptdate,
                                            receiptCode: widget.receiptCode,
                                            hubType: widget.hubType,
                                            paymentMode: widget.paymentMode,
                                            itsNumber: widget.itsNumber,
                                          )));
                            },
                            icon: Icon(Icons.edit)),
                    Text("Receipt#${widget.receiptCode}",
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
                Globals.receiptDetailtext(
                    context, "Receipt Name:", "${widget.fullname ?? ""}"
                    //  "XYZ"
                    ),
                //  Globals.receiptDetailtext(context, "Name:", "${state.name}"),
                Globals.receiptDetailtext(
                    context, "Mohalla:", "${state.mohallah}"
                    // "Zainee"
                    ),
                Globals.receiptDetailtext(
                    context,
                    "Receipt Date & Time:",
                    //"${state.dateController?.text}"
                    "${widget.receiptdate}"
                    //  "10-05-2021 05:10:30"
                    ),
                Globals.receiptDetailtext(
                    context, "MOP:", "${widget.paymentMode}"

                    // "Cash"
                    ),
                Globals.receiptDetailtext(
                    context, "Amount:", "${widget.amount ?? ""}"
                    //   "150.00"
                    ),
                Globals.receiptDetailtext(
                    context, "Receipt Made By:", "${authCub.getUserName}"),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              // BlocProvider.of<ReceiptCubit>(
                                              //         context)
                                              //     .check(true);
                                              BlocProvider.of<ReceiptCubit>(
                                                      context)
                                                  .markpaid(
                                                      context, widget.id ?? 0);
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
                                          widget.isDeposit == 0
                                              ? "Unpaid"
                                              : "Mark Paid",
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
                          if (widget.isDeshboard == true)
                            if (hasWriteDashboard)
                              IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ReceiptCubit>(context)
                                        .deleteReceipt(widget.id ?? 0);
                                    // BlocProvider.of<ReceiptCubit>(context)
                                    //     .getReceipt(widget.id ?? 0);

                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Color(0xff456BD0),
                                  )),
                          if (widget.isDeshboard == false)
                            if (hasWrite)
                              IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ReceiptCubit>(context)
                                        .deleteReceipt(widget.id ?? 0);
                                    // BlocProvider.of<ReceiptCubit>(context)
                                    //     .getReceipt(widget.id ?? 0);

                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Color(0xff456BD0),
                                  )),
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
}
