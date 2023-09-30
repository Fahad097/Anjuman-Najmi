import 'package:anjuman_e_najmi/data/model/permission.dart';
import 'package:anjuman_e_najmi/logic/cubit/authentication/auth_cubit.dart';
import 'package:anjuman_e_najmi/views/budget/budget.dart';
import 'package:anjuman_e_najmi/views/setting/roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/receipt/receipt_cubit.dart';
import '../../logic/cubit/role/role_cubit.dart';
import '../../utils/asset_config.dart';
import '../../utils/global_constants.dart';
import '../receipt/viewreceipt.dart';
import '../report/report.dart';
import '../setting/userrole.dart';
import 'home_tab.dart';

class Home extends StatefulWidget {
  final bool? isAdmin;
  final int? selectedIndex;
  final int? tabIndex;
  Home({super.key, this.selectedIndex, this.tabIndex, this.isAdmin = true});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController2;

  String selectedPage = "User Role";
  ww() async {
    await Globals.mainInit();
    //await BlocProvider.of<AuthCubit>(context).getUser(context);
  }

  @override
  void initState() {
    ww();

    _tabController2 = TabController(
      length: 3,
      vsync: this,
    );
    if (widget.selectedIndex != null) {
      _tabController2.animateTo(widget.selectedIndex!);
    }

    super.initState();
  }

  @override
  void dispose() {
    _tabController2.dispose();
    super.dispose();
  }

  bool hasAccessUser = permissionService.hasPermission('app.user');
  bool hasAccessRole = permissionService.hasPermission('app.user_role');
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 5, 5),
      body: TabBarView(controller: _tabController2, children: [
        HomeTab(),
        //  Budget(selectedIndex: widget.tabIndex != null ? widget.tabIndex : 0),
        ViewReceipt(),
        Report()
      ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xff233C7E), Color(0xff456BD0)])),
        child: TabBar(
          labelColor: Colors.white,
          controller: _tabController2,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2, color: Colors.white),
            //hight of indicator
            insets: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
          ),
          tabs: [
            Tab(icon: ImageIcon(AssetImage(AssetConfig.kTabHome))),
            // Tab(
            //   icon: ImageIcon(AssetImage(AssetConfig.kBudgetTab)),
            //     ),
            Tab(icon: ImageIcon(AssetImage(AssetConfig.kReceiptTab))),
            // Tab(icon: ImageIcon(AssetImage(BlocProvider.of<ReceiptCubit>(context).state.isCheck!? AssetConfig.kmoreHorizontleIcon : AssetConfig.kreadwrite_Icon)),),
            hasAccessRole || hasAccessUser
                ? Tab(
                    child: PopupMenuButton<String>(
                      padding: EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      icon: ImageIcon(
                          AssetImage(AssetConfig.kmoreHorizontleIcon)),
                      iconSize: 100,
                      onSelected: (value) async {
                        setState(() {
                          selectedPage = value;
                          print(selectedPage);
                        });
                        if (selectedPage == "User Management") {
                          BlocProvider.of<AuthCubit>(context)
                              .getAllUser(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => UserRole()));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Roles()));
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        if (hasAccessUser)
                          PopupMenuItem<String>(
                            onTap: () {},
                            value: 'User Management',
                            child: Text(
                              'User Management',
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                color: Globals.kUniversalColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        if (hasAccessRole)
                          PopupMenuItem<String>(
                            onTap: () async {},
                            value: 'User Role',
                            child: Text(
                              'User Role',
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                color: Globals.kUniversalColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : Tab(
                    icon: ImageIcon(AssetImage(AssetConfig.kreadwrite_Icon)),
                  ),
          ],
        ),
      ),
    );
  }
}
