import 'package:anjuman_e_najmi/data/model/permission.dart';
import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:anjuman_e_najmi/utils/asset_config.dart';
import 'package:anjuman_e_najmi/views/receipt/paid.dart';
import 'package:anjuman_e_najmi/views/receipt/pending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/authentication/auth_cubit.dart';
import '../../logic/cubit/receipt/receipt_cubit.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';
import '../authentication/components/asset_provider.dart';

class ViewReceipt extends StatefulWidget {
  const ViewReceipt({Key? key}) : super(key: key);

  @override
  _ViewReceiptState createState() => _ViewReceiptState();
}

class _ViewReceiptState extends State<ViewReceipt>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final cubit = BlocProvider.of<ReceiptCubit>(context, listen: false);
    if (Globals.unpaid == "unpaid") {
      cubit.getpaid(Globals.unpaid, limit: 4);
    } else {
      cubit.getpaid(Globals.paid, limit: 4);
    }
  }

  bool hasAccess = permissionService.hasPermission('app.receipt');
  bool hasWrite = permissionService.hasWritePermission('app.receipt');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xffF5F5F5),
          appBar: PreferredSize(
              preferredSize: Size(
                  Globals.getDeviceWidth(context),
                  isLandscape(context)
                      ? Globals.getDeviceHeight(context) * 0.37
                      : Globals.getDeviceHeight(context) * 0.25),
              child: AppBar(
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
                        color: Colors.white,
                      ),
                      itemBuilder: (context) {
                        return [
                          if (hasAccess && hasWrite)
                            PopupMenuItem<int>(
                                value: 0,
                                child: Row(
                                  children: [
                                    AssetProvider(
                                        asset: AssetConfig.kReceiptIcon,
                                        width: 20,
                                        height: 20,
                                        color: Color(0xff717171)),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text("Add Receipt",
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
                          context.read<ReceiptCubit>().lastReceiptNumber();
                          context.read<ReceiptCubit>().getPayment();
                          context.read<ReceiptCubit>().getHubType();
                          Navigator.pushNamed(context, addReceipt);
                        } else if (value == 1) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  Globals.popupDialog(
                                      context,
                                      () => context
                                          .read<AuthCubit>()
                                          .flogOut(context),
                                      () => Navigator.pop(context),
                                      "Are you sure you want to logout?"));
                        }
                      })
                ],
                leading: Container(),
                centerTitle: true,
                title: Text(
                  "Receipt",
                  style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 22),
                ),
                flexibleSpace: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Color(0xff233C7E),
                          Color(0xff456BD0)
                        ])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 15.0,
                              right: 15,
                              top: isLandscape(context)
                                  ? Globals.getDeviceHeight(context) * 0.19
                                  : Globals.getDeviceHeight(context) * 0.14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                              onChanged: (val) {},
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                focusColor: Color(0xffE4F9E8),
                                border: InputBorder.none,
                                hintText: "Search",
                                helperStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                suffixIconConstraints:
                                    BoxConstraints(minWidth: 25, minHeight: 25),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(left: 5, right: 12),
                                  child: ImageIcon(
                                    AssetImage(AssetConfig.ksearchUser),
                                    size: 20,
                                  ),
                                ),
                                prefixIconColor: Colors.grey,
                              )),
                        ),
                        state.accesses?[1].access != "n"
                            ? TabBar(
                                labelStyle: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: 16),
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: Colors.white,
                                controller: _tabController,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.white,
                                indicator: UnderlineTabIndicator(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.white),
                                  //hight of indicator
                                  insets: EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 11),
                                ),
                                onTap: (i) {},
                                tabs: const [
                                  // first tab [you can add an icon using the icon property]
                                  Tab(
                                    text: 'Pending',
                                  ),

                                  Tab(
                                    text: 'Paid',
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 10,
                              ),
                      ],
                    ),
                  ),
                ),
              )),
          floatingActionButton:
              // state.accesses?[1].access == "w"
              //     ?
              (hasAccess && hasWrite)
                  ? FloatingActionButton(
                      child: ImageIcon(AssetImage(AssetConfig.kReceiptIcon)),
                      backgroundColor: Globals.kUniversalColor,
                      onPressed: () {
                        context.read<ReceiptCubit>().lastReceiptNumber();
                        context.read<ReceiptCubit>().getPayment();
                        context.read<ReceiptCubit>().getHubType();
                        Navigator.pushNamed(context, addReceipt);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => Pagination()));
                      })
                  : SizedBox(),
          body: (hasAccess)
              ? TabBarView(
                  controller: _tabController,
                  children: [Pending(), Paid()],
                )
              : SizedBox(
                  child: Center(child: Text("You don't have Access")),
                ),
        );
      },
    );
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xff233C7E), Color(0xff456BD0)]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Globals.getDeviceHeight(context) * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                          value: 0,
                          child: Row(
                            children: [
                              AssetProvider(
                                  asset: AssetConfig.kReceiptIcon,
                                  width: 20,
                                  height: 20,
                                  color: Color(0xff717171)),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Add Receipt",
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    color: Globals.kUniversalColor,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          )),
                      PopupMenuItem<int>(
                          value: 2,
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
                      Navigator.pushNamed(context, addReceipt);
                    } else if (value == 1) {
                      Navigator.pushNamed(context, profile);
                    } else if (value == 2) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              Globals.popupDialog(
                                  context,
                                  () => context
                                      .read<AuthCubit>()
                                      .flogOut(context),
                                  () => Navigator.pop(context),
                                  "Are you sure you want to logout?"));
                    }
                  })
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Receipt",
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 22),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
                onChanged: (val) {},
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  focusColor: Color(0xffE4F9E8),
                  border: InputBorder.none,
                  hintText: "Search",
                  helperStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIconConstraints:
                      BoxConstraints(minWidth: 25, minHeight: 25),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(left: 5, right: 12),
                    child: ImageIcon(
                      AssetImage(AssetConfig.ksearchUser),
                      size: 20,
                    ),
                  ),
                  prefixIconColor: Colors.grey,
                )),
          ),
          TabBar(
            labelStyle: TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16),
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.all(0),
            indicatorColor: Colors.white,
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            onTap: (i) {},
            tabs: const [
              // first tab [you can add an icon using the icon property]
              Tab(
                text: 'Pending',
              ),

              Tab(
                text: 'Paid',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
