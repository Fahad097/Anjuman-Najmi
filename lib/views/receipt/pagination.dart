import 'package:anjuman_e_najmi/logic/cubit/receipt/receipt_cubit.dart';
import 'package:anjuman_e_najmi/views/receipt/components/viewrecceiptunpaid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/global_constants.dart';

class Pagination extends StatefulWidget {
  const Pagination({Key? key}) : super(key: key);

  @override
  _PaginationState createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  bool isLoading = false;

  refres() async {
    setState(() {
      isLoading = false;
    });
    print("Okay");
    // context.read<ReceiptCubit>().resetOffSet();
    // context.read<ReceiptCubit>().getpaid(limit: 2);
  }

  final scrollcontroller = ScrollController();
  @override
  void initState() {
    super.initState();

    scrollcontroller.addListener(pagination);
    // BlocProvider.of<ReceiptCubit>(context).getReceiptAll();
    BlocProvider.of<ReceiptCubit>(context).getpaid(limit: 2, Globals.unpaid);
  }

  void pagination() async {
    debugPrint("sdcdc");
    if (!context.read<ReceiptCubit>().state.isloading! &&
        context.read<ReceiptCubit>().state.oldReceiptList != null &&
        scrollcontroller.offset >= scrollcontroller.position.maxScrollExtent) {
      debugPrint(scrollcontroller.toString());
      await context.read<ReceiptCubit>().updateOffSet();
      BlocProvider.of<ReceiptCubit>(context).getpaid(limit: 2, Globals.unpaid);
      //add api for load the more data according to new page
    }
    debugPrint(
        "Pagination${context.read<ReceiptCubit>().state.isloading}  offest  ${context.read<ReceiptCubit>().state.offset}");
  }

  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          pagination();
        }
        return true;
      },
      child: BlocBuilder<ReceiptCubit, ReceiptState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: state.isloading!
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      controller: scrollcontroller,
                      child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          // controller: scrollcontroller,
                          padding: EdgeInsets.only(top: 0),
                          itemCount: state.receipt!.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, i) {
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
                                          receiptdate:
                                              state.receipt?[i].createdOn,
                                          receiptCode:
                                              state.receipt?[i].receiptCode,
                                          itsNumber:
                                              state.receipt?[i].itsNumber,
                                          hubType: state.receipt?[i].hubType,
                                          paymentMode:
                                              state.receipt?[i].paymentMode,
                                          isDeposit:
                                              state.receipt?[i].isDeposited,
                                          isDeshboard: false,
                                        ));
                              },
                              child: Card(
                                shadowColor: Globals.kUniversalColor,
                                margin: const EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                state.receipt?[i].fullname ??
                                                    "",
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
                          }),
                    ));
        },
      ),
    );
  }
}
// Container(
//                                       width: 150,
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 10),
//                                       child: DropdownButtonHideUnderline(
//                                         child: DropdownButton(
//                                           onChanged: (newValue) {
//                                             // {id: 4, name: Receipt, code: app.receipt, permission: w}
// // { Add UserROle
// //   "name": "Role",
// //   "permission": {"app.dashboard":"w"}
// // }
//                                             // BlocProvider.of<AccessCubit>(
//                                             //         context)
//                                             //     .updateAccess(index, newValue!);
//                                             BlocProvider.of<RoleCubit>(context)
//                                                 .updateValue(index, newValue);

//                                             // print("RRR $newValue");
//                                           },
//                                           icon: ImageIcon(
//                                             AssetImage(
//                                                 AssetConfig.kdropdownIcon),
//                                             color: Color(0xff86A3F0),
//                                             size: 12,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           value: state.permission![
//                                               state.userRole![index].code],
//                                           items: dropdownItems,
//                                         ),
//                                       ),
//                                     )