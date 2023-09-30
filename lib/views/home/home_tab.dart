import 'package:anjuman_e_najmi/data/model/permission.dart';
import 'package:anjuman_e_najmi/data/model/receipt_model.dart';
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
    BlocProvider.of<ReceiptCubit>(context).state.receipt?.clear();

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

                      // (isloading == true)
                      //     ? (!hasAccess)
                      //         ? SizedBox()
                      //         : DashboardWidget(
                      //             title: "Receipt",
                      //           )
                      //     : Center(
                      //         child: CircularProgressIndicator(),
                      //       ),

                      SizedBox(
                        height: Globals.getDeviceHeight(context) * 0.03,
                      ),
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
}

class DashboardWidget extends StatelessWidget {
  final String title;

  DashboardWidget({required this.title});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptCubit, ReceiptState>(builder: (context, state) {
      int startIndex =
          (state.receipt?.length ?? -2) < 1 ? 1 : state.receipt?.length ?? -2;
      List<ReceiptModel>? slicedList = state.receipt?.sublist(1);
      print(slicedList?.length);
      print("Sliced");
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
                return InkWell(
                  onTap: () async {
                    context.read<ReceiptCubit>().resetOffSet();
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) => ViewReceiptUnPaid(
                              index: i,
                              receipt: state.receipt,
                              isDeshboard: true,
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
                                "#${slicedList?[i].receiptCode}".toString(),
                                style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w400,
                                    color: Globals.kUniversalColor,
                                    fontSize: 15),
                              ),
                              Spacer(),
                              Text(
                                  "Date:${slicedList?[i].depositDate.toString()

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
                                child: Text(slicedList?[i].fullname ?? "",
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff858585),
                                        fontSize: 16)),
                              ),
                              Spacer(),
                              Text(
                                "Time:${slicedList?[i].createdOn.toString()}",
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
        ],
      );
    });
  }
}
