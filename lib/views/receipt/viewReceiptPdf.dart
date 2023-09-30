import 'package:anjuman_e_najmi/logic/cubit/authentication/auth_cubit.dart';
import 'package:anjuman_e_najmi/logic/cubit/receipt/receipt_cubit.dart';
import 'package:anjuman_e_najmi/utils/asset_config.dart';
import 'package:anjuman_e_najmi/utils/global_constants.dart';
import 'package:anjuman_e_najmi/views/authentication/components/asset_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../routes/routes_names.dart';

/// Represents Homepage for Navigation
class ViewReceiptPdf extends StatelessWidget {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
          ),
          Spacer(),
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
                color: Globals.kUniversalColor,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                      value: 0,
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
                                color: Globals.kUniversalColor,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      )),
                  PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          AssetProvider(
                              asset: "assets/logout.png",
                              width: 20,
                              height: 20,
                              color: Color(0xff717171)),
                          SizedBox(
                            width: 3,
                          ),
                          Text("logout",
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                color: Globals.kUniversalColor,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      )),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  context
                      .read<AuthCubit>()
                      .getProfile(context, authCub.getuserID);
                  Navigator.pushNamed(context, profile);
                } else if (value == 1) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => Globals.popupDialog(
                          context,
                          () => context.read<AuthCubit>().flogOut(context),
                          () => Navigator.pop(context),
                          "Are you sure you want to logout?"));
                }
              })
        ],
        leading: Container(),
      ),
      body: BlocBuilder<ReceiptCubit, ReceiptState>(
        builder: (context, state) {
          return SfPdfViewer.network(
            state.receiptPDF ?? '',
            key: _pdfViewerKey,
          );
        },
      ),
    );
  }
}
