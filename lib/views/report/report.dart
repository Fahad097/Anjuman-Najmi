import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:anjuman_e_najmi/utils/asset_config.dart';
import 'package:anjuman_e_najmi/views/receipt/receiptreport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/authentication/auth_cubit.dart';
import '../../logic/cubit/receipt/receipt_cubit.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';
import '../authentication/components/asset_provider.dart';
import '../budget/budgetreport.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> with TickerProviderStateMixin {
  late TabController _tabController;

  bool value = false;
  bool btncheck = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    print("Report ${BlocProvider.of<ReceiptCubit>(context).state.isCheck!}");
  }

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: PreferredSize(
            preferredSize: Size(
                Globals.getDeviceWidth(context),
                isLandscape(context)
                    ? Globals.getDeviceHeight(context) * 0.42
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
                        //  Navigator.pushNamed(context, rolesManagement);
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
              leading: Container(),
              centerTitle: true,
              title: Text(
                "Report",
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 22),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xff233C7E), Color(0xff456BD0)])),
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
                              : Globals.getDeviceHeight(context) * 0.12),
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
                      indicatorColor: Colors.white,
                      controller: _tabController,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        //hight of indicator
                        insets:
                            EdgeInsets.symmetric(horizontal: 4.0, vertical: 11),
                      ),
                      onTap: (i) {},
                      tabs: const [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          text: 'Budget',
                        ),

                        Tab(
                          text: 'Receipt',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        body: TabBarView(
          controller: _tabController,
          children: [BudgetReport(), ReceiptReport()],
        ));
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xff233C7E), Color(0xff456BD0)])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Globals.getDeviceHeight(context) * 0.04,
          ),
          Row(
            children: [
              // IconButton(
              //   icon: Icon(Icons.arrow_back_ios),
              //   color: Colors.white,
              //   onPressed: () {
              //     Navigator.pop(context);
              //     Navigator.pop(context);
              //   },
              // ),
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
                    color: Colors.white,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      //  Navigator.pushNamed(context, rolesManagement);
                    } else if (value == 1) {
                      Navigator.pushNamed(context, profile);
                    } else if (value == 2) {
                      context.read<AuthCubit>().flogOut(context);
                    }
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Text(
              "Report",
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
                onChanged: (val) {},
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  focusColor: Color(0xffE4F9E8),
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.w400,
                      color: Globals.kFiledColor,
                      fontSize: 14),
                  helperStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  suffixIconConstraints:
                      BoxConstraints(minWidth: 25, minHeight: 25),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(left: 5, right: 15),
                    child: ImageIcon(
                      AssetImage(AssetConfig.ksearchUser),
                      color: Globals.kFiledColor,
                      size: 20,
                    ),
                  ),
                  prefixIconColor: Color(0xff9E9D9D),
                )),
          ),
        ],
      ),
    );
  }
}

class StyledSwitch extends StatefulWidget {
  final void Function(bool isToggled) onToggled;

  const StyledSwitch({Key? key, required this.onToggled}) : super(key: key);

  @override
  State<StyledSwitch> createState() => _StyledSwitchState();
}

class _StyledSwitchState extends State<StyledSwitch> {
  bool isToggled = false;
  double size = 20;
  double innerPadding = 0;

  @override
  void initState() {
    innerPadding = size / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled);
      },
      onPanEnd: (b) {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled);
      },
      child: AnimatedContainer(
        height: size,
        width: size * 1.5,
        padding: EdgeInsets.all(innerPadding),
        alignment: isToggled ? Alignment.centerLeft : Alignment.centerRight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isToggled ? Color(0xff888888) : Globals.kUniversalColor,
          ),
        ),
        child: Container(
          width: size - innerPadding * 0.02,
          height: size - innerPadding * 0.02,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(100),
            shape: BoxShape.circle,
            //isToggled ? Colors.blue.shade600 : Colors.grey.shade500,
            color: isToggled ? Color(0xff888888) : Globals.kUniversalColor,
          ),
        ),
      ),
    );
  }
}
