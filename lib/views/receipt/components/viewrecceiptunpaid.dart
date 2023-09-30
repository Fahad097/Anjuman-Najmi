import 'package:anjuman_e_najmi/data/model/permission.dart';
import 'package:anjuman_e_najmi/data/model/receipt_model.dart';
import 'package:anjuman_e_najmi/views/receipt/viewReceiptPdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/authentication/auth_cubit.dart';
import '../../../logic/cubit/receipt/receipt_cubit.dart';
import '../../../utils/global_constants.dart';
import '../../../utils/landscape_mode.dart';
import '../edit_receipt.dart';

class ViewReceiptUnPaid extends StatefulWidget {
  ViewReceiptUnPaid({super.key, this.index, this.receipt, this.isDeshboard});

  int? index;
  List<ReceiptModel>? receipt;
  bool? isDeshboard;

  @override
  State<ViewReceiptUnPaid> createState() => _ViewReceiptUnPaidState();
}

class _ViewReceiptUnPaidState extends State<ViewReceiptUnPaid> {
  @override
  void initState() {
    // BlocProvider.of<ReceiptCubit>(context).getReceipt(widget.id ?? 0);

    super.initState();
  }

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
                                            // receitId: widget
                                            //     .receipt?[widget.index ?? 0].id,
                                            // fullname: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .fullname,
                                            // amount: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .hubAmount,
                                            // receiptdate: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .createdOn,
                                            // receiptCode: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .receiptCode,
                                            // hubType: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .hubType,
                                            // paymentMode: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .paymentMode,
                                            // itsNumber: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .itsNumber,
                                            // zabihatCount: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .zabihatCount
                                            receipt: state.receipt,
                                            index: widget.index,
                                          )));
                            },
                            icon: Icon(Icons.edit)),
                    if (widget.isDeshboard == false)
                      if (hasWrite)
                        IconButton(
                            onPressed: () {
                              context.read<ReceiptCubit>().getPayment();
                              context.read<ReceiptCubit>().getHubType();

                              Navigator.pop(context);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => EditReceipt(
                                            // receitId: widget
                                            //     .receipt?[widget.index ?? 0].id,
                                            // fullname: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .fullname,
                                            // amount: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .hubAmount,
                                            // receiptdate: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .createdOn,
                                            // receiptCode: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .receiptCode,
                                            // hubType: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .hubType,
                                            // paymentMode: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .paymentMode,
                                            // itsNumber: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .itsNumber,
                                            // zabihatCount: widget
                                            //     .receipt?[widget.index ?? 0]
                                            //     .zabihatCount
                                            receipt: state.receipt,
                                            index: widget.index,
                                          )));
                            },
                            icon: Icon(Icons.edit)),
                    Text(
                        "Receipt#${widget.receipt?[widget.index ?? 0].receiptCode}",
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
                Globals.receiptDetailtext(context, "Receipt Name:",
                    "${widget.receipt?[widget.index ?? 0].fullname ?? ""}"
                    //  "XYZ"
                    ),
                //  Globals.receiptDetailtext(context, "Name:", "${state.name}"),
                Globals.receiptDetailtext(context, "Mohalla:",
                    "${widget.receipt?[widget.index ?? 0].mohallahName ?? ""}"
                    // "Zainee"
                    ),
                Globals.receiptDetailtext(
                    context,
                    "Receipt Date & Time:",
                    //"${state.dateController?.text}"
                    "${widget.receipt?[widget.index ?? 0].createdOn.toString()}"
                    //  "10-05-2021 05:10:30"
                    ),
                Globals.receiptDetailtext(context, "MOP:",
                    "${widget.receipt?[widget.index ?? 0].paymentTitle ?? ""}"

                    // "Cash"
                    ),
                Globals.receiptDetailtext(context, "Amount:",
                    "${widget.receipt?[widget.index ?? 0].hubAmount ?? ""}"
                    //   "150.00"
                    ),
                Globals.receiptDetailtext(context, "Receipt Made By:",
                    "${widget.receipt?[widget.index ?? 0].createdBy}"),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (hasWritePaid)
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(colors: [
                                    Color(0xff233C7E),
                                    Color(0xff456BD0)
                                  ])),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        Globals.receiptpaidDialog(context,
                                            () async {
                                          await BlocProvider.of<ReceiptCubit>(
                                                  context)
                                              .markpaid(
                                                  context,
                                                  widget.receipt ?? [],
                                                  widget.index ?? 0);
                                          await BlocProvider.of<ReceiptCubit>(
                                                  context)
                                              .getpaid(limit: 4, Globals.paid);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }, () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        })),
                                child: BlocBuilder<ReceiptCubit, ReceiptState>(
                                  builder: (context, state) {
                                    return Text(
                                      widget.receipt?[widget.index ?? 0]
                                                  .isDeposited ==
                                              1
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
                            ),
                          if (!hasWritePaid) SizedBox(),
                          if (widget.isDeshboard == true)
                            if (hasWriteDashboard)
                              IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ReceiptCubit>(context)
                                        .deleteReceipt(widget
                                                .receipt?[widget.index ?? 0]
                                                .id ??
                                            0);

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
                                  onPressed: () async {
                                    await BlocProvider.of<ReceiptCubit>(context)
                                        .deleteReceipt(widget
                                                .receipt?[widget.index ?? 0]
                                                .id ??
                                            0);
                                    await BlocProvider.of<ReceiptCubit>(context)
                                        .getpaid(limit: 4, Globals.paid);
                                    await Globals.showToast(
                                        " Receipt deleted successfully");
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

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: (state.isloading ?? false)
                          ? CircularProgressIndicator()
                          : Text(
                              'View Pdf',
                              style: TextStyle(color: Color(0xff456BD0)),
                            ),
                      onTap: () async {
                        print(widget.receipt![widget.index ?? 0].id);
                        await BlocProvider.of<ReceiptCubit>(context)
                            .getReceiptURL(
                                widget.receipt![widget.index ?? 0].id ?? 0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ViewReceiptPdf())));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
