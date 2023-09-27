import 'package:anjuman_e_najmi/data/model/login_response.dart';
import 'package:anjuman_e_najmi/data/model/permission.dart';
import 'package:anjuman_e_najmi/logic/cubit/authentication/auth_cubit.dart';
import 'package:anjuman_e_najmi/utils/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/receipt/receipt_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/asset_config.dart';
import '../authentication/components/asset_provider.dart';
import '../receipt/components/viewrecceiptunpaid.dart';
import 'home.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var isloading = false;
  void _loadPaid() async {
    await BlocProvider.of<ReceiptCubit>(context)
        .getpaid(Globals.paid, limit: 4);
    setState(() {
      isloading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPaid();
  }

  @override
  Widget build(BuildContext context) {
    bool hasAccess = permissionService.hasPermission('app.dashboard.receipt');
    print("My LIST" + permissionService.userPermissions.toString());
    print("My LIST" + hasAccess.toString());
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
        elevation: 0.0,
        actions: [
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  // BlocProvider.of<AuthCubit>(context).getRoleAccess(1);
                  // print("In home tab: ${state.accesses?[0]}");
                  debugPrint("WWWWW ${state.permission}");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("welcome",
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w400,
                              color: Color(0xff706B6B),
                              fontSize: 20)),
                      SizedBox(
                        height: Globals.getDeviceHeight(context) * 0.01,
                      ),
                      Text(Globals.isTextNullOrEmptyString(authCub.getUserName),
                          //"Marcel",
                          style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w400,
                              color: Globals.kUniversalColor,
                              fontSize: 37)),
                      SizedBox(
                        height: Globals.getDeviceHeight(context) * 0.03,
                      ),
                      // (state.accesses?[0].childResources?[0].access == "w" ||
                      //             state.accesses?[0].childResources?[0]
                      //                     .access ==
                      //                 "r") &&
                      //         (state.accesses?[0].access != "n")
                      // (state.permission == "w" ||
                      //             response.userModel?.permissions!
                      //                     .appDashboard ==
                      //                 "r") &&
                      //         (state.permission != "n")
                      //    ?
                      (isloading == true)
                          ? (!hasAccess)
                              ? SizedBox()
                              : DashboardWidget(
                                  title: "Receipt",
                                )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      //  : SizedBox(),
                      SizedBox(
                        height: Globals.getDeviceHeight(context) * 0.03,
                      ),
                      // (state.accesses?[0].childResources?[1].access == "r" ||
                      //             state.accesses?[0].childResources?[1]
                      //                     .access ==
                      //                 "w") &&
                      //         (state.accesses?[0].access != "n")
                      // (state.permission == "r" || state.permission == "w") &&
                      //         (state.permission != "n")
                      // ?
                      // DashboardWidget(title: "Budget")
                      // : SizedBox(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
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
              "Are you sure?",
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff525252),
                  fontSize: 22),
            ),
            Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat.",
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
              DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xff456BD0), width: 1.2),
                    gradient: LinearGradient(
                        colors: [Color(0xff233C7E), Color(0xff456BD0)])),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
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
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xff456BD0), width: 1.2),
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
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
}

class DashboardWidget extends StatelessWidget {
  final String title;

  DashboardWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    return BlocBuilder<ReceiptCubit, ReceiptState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title history",
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5A5A5A),
                  fontSize: 18)),
          SizedBox(
            height: Globals.getDeviceHeight(context) * 0.015,
          ),
          Row(
            children: [
              Text("Today",
                  style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w400,
                      color: Color(0xff706B6B),
                      fontSize: 14)),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Home(selectedIndex: 2)));
                },
                child: Text("View All",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5D74AF),
                        fontSize: 14)),
              )
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 0),
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (ctx, i) {
                if (i < state.receipt!.length + 1) {
                  return InkWell(
                    onTap: () async {
                      context.read<ReceiptCubit>().resetOffSet();
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) => ViewReceiptUnPaid(
                                id: state.receipt?[i].id ?? 0,
                                fullname: state.receipt?[i].fullname,
                                amount: state.receipt?[i].hubAmount,
                                receiptdate: state.receipt?[i].createdOn,
                                receiptCode: state.receipt?[i].receiptCode,
                                itsNumber: state.receipt?[i].itsNumber,
                                hubType: state.receipt?[i].hubType,
                                paymentMode: state.receipt?[i].paymentMode,
                                isDeposit: state.receipt?[i].isDeposited,
                              ));
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
              }),
        ],
      );
    });
  }
}
