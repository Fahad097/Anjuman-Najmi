import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/receipt/receipt_cubit.dart';
import '../../utils/asset_config.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';
import '../authentication/components/asset_provider.dart';
import '../receipt/addreceipt.dart';

class AddUserRole extends StatelessWidget {
  AddUserRole({super.key});

  final int index = 0;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode _dateFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: BlocBuilder<ReceiptCubit, ReceiptState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(children: [
                Stack(children: [
                  AssetProvider(
                    asset: AssetConfig.kSignInPageImage,
                    height: isLandscape(context)
                        ? Globals.getDeviceHeight(context) * 0.85
                        : Globals.getDeviceHeight(context) * 0.67,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Globals.getDeviceHeight(context) * 0.04,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                              Text("Add UserRole",
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  )),
                              // Spacer(),
                              PopupMenuButton(
                                  padding: EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(0),
                                    ),
                                  ),
                                  icon: ImageIcon(
                                    AssetImage(AssetConfig.kMoreIcon),
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem<int>(
                                          value: 1,
                                          child: Row(
                                            children: [
                                              AssetProvider(
                                                  asset: "assets/user_icon.png",
                                                  width: 20,
                                                  height: 20,
                                                  color: Color(0xff717171)),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text("Profile",
                                                  style: TextStyle(
                                                    fontFamily: 'Helvetica',
                                                    color:
                                                        Globals.kUniversalColor,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ],
                                          )),
                                    ];
                                  },
                                  onSelected: (value) {
                                    if (value == 0) {
                                      Navigator.pushNamed(context, viewReceipt);
                                    } else if (value == 1) {
                                      Navigator.pushNamed(context, profile);
                                    } else if (value == 2) {
                                      print("Logout menu is selected.");
                                    }
                                  }),
                            ]),
                        Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(left: 15, right: 15, top: 8),
                          width: Globals.getDeviceWidth(context),
                          height: isLandscape(context)
                              ? Globals.getDeviceHeight(context) * 1.4
                              : Globals.getDeviceHeight(context) * 0.79,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // DropdownButtonFormField(
                                //     autovalidateMode:
                                //         AutovalidateMode.onUserInteraction,
                                //     hint: Text("Select Receipt Type"),
                                //     icon: ImageIcon(
                                //       AssetImage(AssetConfig.kdropdownIcon),
                                //       color: Colors.grey,
                                //       size: 16,
                                //     ),
                                //     borderRadius: BorderRadius.circular(20),
                                //     decoration: InputDecoration(
                                //         contentPadding: EdgeInsets.all(13),
                                //         border: OutlineInputBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(15)),
                                //         fillColor: Globals.kFiledColor),
                                //     validator: (value) => value == null
                                //         ? "Receipt Type is required"
                                //         : null,
                                //     style: TextStyle(
                                //       fontFamily: 'Helvetica',
                                //       color: Color(0xff6D6D6D),
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.w400,
                                //     ),
                                //     // onChanged: (value) =>
                                //     //     value!.isNotEmpty && value != ''
                                //     //         ? context
                                //     //             .read<ReceiptCubit>()
                                //     //             .receiptType(value)
                                //     //         : print("$value"),
                                //     items: receipttype.map((item) {
                                //       return DropdownMenuItem(
                                //         value: item,
                                //         child: Text(item),
                                //       );
                                //     }).toList()),

                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'ITS Number is required';
                                    }
                                    if (value.trim().length > 15) {
                                      return 'Dont Exceed the text Limit';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => value.isNotEmpty &&
                                          value != '' &&
                                          value.trim().length <= 15
                                      ? context
                                          .read<ReceiptCubit>()
                                          .itsNumber(int.parse(value))
                                      : print("$value"),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: "ITS Number",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Helvetica',
                                      color: Globals.kFiledColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    contentPadding: EdgeInsets.all(17),
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Mohallah  is required';
                                    }
                                    if (value.trim().length > 50) {
                                      return 'Dont Exceed the text Limit';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => value.isNotEmpty &&
                                          value != '' &&
                                          value.trim().length <= 70
                                      ? context
                                          .read<ReceiptCubit>()
                                          .mohallah(value)
                                      : print("$value"),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: "Mohallah",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Helvetica',
                                      color: Globals.kFiledColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    contentPadding: EdgeInsets.all(17),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Amount is required';
                                    }
                                    if (value.trim().length > 15) {
                                      return 'Dont Exceed the text Limit';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => value.isNotEmpty &&
                                          int.parse(value) != 0 &&
                                          value.trim().length <= 15
                                      ? context
                                          .read<ReceiptCubit>()
                                          .amount(value)
                                      : print("$value"),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: "Amount",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Helvetica',
                                      color: Globals.kFiledColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    contentPadding: EdgeInsets.all(17),
                                  ),
                                ),
                                DropdownButtonFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    hint: Text("Select Payment mode"),
                                    icon: ImageIcon(
                                      AssetImage(AssetConfig.kdropdownIcon),
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(13),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        fillColor: Globals.kFiledColor),
                                    validator: (value) => value == null
                                        ? "Payment mode is required"
                                        : null,
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      color: Color(0xff6D6D6D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    onChanged: (value) =>
                                        value!.isNotEmpty && value != ''
                                            ? context
                                                .read<ReceiptCubit>()
                                                .paymentMode(int.parse(value))
                                            : print("$value"),
                                    items: paymentmode.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList()),
                                TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      color: Color(0xff6D6D6D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    focusNode: _dateFocusNode,
                                    controller: state.dateController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Date is required';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      context
                                          .read<ReceiptCubit>()
                                          .selectDate(context);
                                      _dateFocusNode.unfocus();
                                    },
                                    decoration: InputDecoration(
                                        suffixIconColor: Colors.grey,
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
                                          child: ImageIcon(
                                            size: 16,
                                            AssetImage(
                                                AssetConfig.kdropdownIcon),
                                          ),
                                        ),
                                        hintText: 'Select Date',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Helvetica',
                                          color: Color(0xff6D6D6D),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ))),
                              ]),
                        )
                      ])
                ])
              ]),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    colors: [Color(0xff233C7E), Color(0xff456BD0)])),
            child: MaterialButton(
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minWidth: double.infinity,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await context.read<ReceiptCubit>().addReceipts(context);
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
