import 'package:anjuman_e_najmi/utils/asset_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/authentication/auth_cubit.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';
import '../authentication/components/asset_provider.dart';
import 'components/createbudget.dart';

class Budget extends StatefulWidget {
  final int? selectedIndex;
  Budget({Key? key, this.selectedIndex}) : super(key: key);

  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> with TickerProviderStateMixin {
  late TabController _tabController;
  // late ScrollController _scrollController;

  @override
  void initState() {
    //  _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    if (widget.selectedIndex != null) {
      _tabController.animateTo(widget.selectedIndex!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: PreferredSize(
          preferredSize: Size(
              Globals.getDeviceWidth(context),
              isLandscape(context)
                  ? Globals.getDeviceHeight(context) * 0.42
                  : Globals.getDeviceHeight(context) * 0.27),
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
                  icon: ImageIcon(AssetImage(AssetConfig.kMoreIcon),
                      color: Colors.white),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AssetProvider(
                                  asset: "assets/upload_icon.png",
                                  width: 20,
                                  height: 20,
                                  color: Color(0xff717171)),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Upload File",
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
                      // Navigator.pushNamed(context, addReceipt);
                    } else if (value == 1) {
                      // Navigator.pushNamed(context, profile);
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
                  }),
            ],
            leading: Container(),
            centerTitle: true,
            title: Text(
              "Budget",
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
                        colors: <Color>[Color(0xff233C7E), Color(0xff456BD0)])),
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Column(
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
                        state.accesses?[1].access == 'r' ||
                                state.accesses?[1].access == 'w'
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
                                tabs: [
                                  // first tab [you can add an icon using the icon property]
                                  if (state.accesses?[1].access == 'w')
                                    Tab(
                                      text: 'Create',
                                    ),

                                  Tab(
                                    text: 'View',
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 10,
                              )
                      ],
                    );
                  },
                ),
              ),
            ),
          )),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            children: [
              if (state.accesses?[1].access == 'w') CreateBudget(),
              Icon(Icons.bike_scooter)
            ],
          );
        },
      ),
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
                  icon: ImageIcon(AssetImage(AssetConfig.kMoreIcon),
                      color: Colors.white),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AssetProvider(
                                  asset: "assets/upload_icon.png",
                                  width: 20,
                                  height: 20,
                                  color: Color(0xff717171)),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Upload File",
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
                      // Navigator.pushNamed(context, addReceipt);
                    } else if (value == 1) {
                      // Navigator.pushNamed(context, profile);
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
                  }),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Create Budget",
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 22),
            ),
          ),
          SizedBox(
            height: Globals.getDeviceHeight(context) * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
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
                text: 'Create',
              ),

              Tab(
                text: 'View',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
