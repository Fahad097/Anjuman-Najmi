import 'package:anjuman_e_najmi/data/model/permission.dart';
import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:anjuman_e_najmi/utils/asset_config.dart';
import 'package:anjuman_e_najmi/views/userManagement/adduser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/authentication/auth_cubit.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';
import '../authentication/components/asset_provider.dart';
import '../home/home.dart';
import '../profile/profile.dart';

class UserRole extends StatefulWidget {
  const UserRole({Key? key}) : super(key: key);

  @override
  _UserRoleState createState() => _UserRoleState();
}

class _UserRoleState extends State<UserRole> {
  bool value = false;
  bool btncheck = false;
  int index = 0;
  var ichceeckd = true;
  bool isloading = false;
  AuthCubit? authCub;

  @override
  void initState() {
    authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    setState(() {
      isloading = true;
    });
    super.initState();
  }

  bool hasWriteUser = permissionService.hasWritePermission('app.user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: PreferredSize(
            preferredSize: Size(
                Globals.getDeviceWidth(context),
                isLandscape(context)
                    ? Globals.getDeviceHeight(context) * 0.36
                    : Globals.getDeviceHeight(context) * 0.21),
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
                        if (hasWriteUser)
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
                                  Text("AddUser",
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
                        //  Navigator.pushNamed(context, budgetreport);
                      } else if (value == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddUser(
                                      userModel:
                                          BlocProvider.of<AuthCubit>(context)
                                              .userList[index],
                                    )));
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
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              title: Text(
                "User Management",
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
                    SizedBox(
                      height: isLandscape(context)
                          ? Globals.getDeviceHeight(context) * 0.18
                          : Globals.getDeviceHeight(context) * 0.09,
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
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
                  ],
                ),
              ),
            )),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Globals.getDeviceWidth(context) * 0.19,
                            child: Text(
                              "Username",
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5978C8),
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            width: Globals.getDeviceWidth(context) * 0.15,
                            child: Text(
                              "Role",
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5978C8),
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            width: Globals.getDeviceWidth(context) * 0.23,
                            child: Text(
                              "Date added",
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5978C8),
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            width: Globals.getDeviceWidth(context) * 0.12,
                            child: Text(
                              "Status",
                              style: TextStyle(
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5978C8),
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  (isloading == false)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.transparent,
                                height: 10,
                              ),
                          itemCount: state.userList?.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          itemBuilder: (context, index) => InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Profile(
                                            userModel: state.userList?[index],
                                            i: index,
                                            btncheck: "GetUser"))),
                                // Navigator.pushNamed(context, rolesManagement),
                                child: Container(
                                  height: 45,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 25,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: isLandscape(context)
                                                  ? Globals.getDeviceWidth(
                                                          context) *
                                                      0.25
                                                  : Globals.getDeviceWidth(
                                                          context) *
                                                      0.22,
                                              child: Text(
                                                state.userList![index].username
                                                    .toString(),
                                                //  "User A",
                                                style: TextStyle(
                                                    fontFamily: 'Helvetica',
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff787878),
                                                    fontSize: 14),
                                              ),
                                            ),
                                            SizedBox(
                                              width: isLandscape(context)
                                                  ? Globals.getDeviceWidth(
                                                          context) *
                                                      0.22
                                                  : Globals.getDeviceWidth(
                                                          context) *
                                                      0.2,
                                              child: Text(
                                                state.userList![index].roleName
                                                    .toString(),
                                                // "Admin",
                                                style: TextStyle(
                                                    fontFamily: 'Helvetica',
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff787878),
                                                    fontSize: 14),
                                              ),
                                            ),
                                            SizedBox(
                                              width: isLandscape(context)
                                                  ? Globals.getDeviceWidth(
                                                          context) *
                                                      0.16
                                                  : Globals.getDeviceWidth(
                                                          context) *
                                                      0.2,
                                              child: Text(
                                                //"$convertdate",
                                                state.userList![index].createdAt
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Helvetica',
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff787878),
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // StyledSwitch(
                                      //   onToggled: (bool isToggled) {
                                      //     final int userId =
                                      //         state.userList?[index].id ?? 0;
                                      //     final int isPending =
                                      //         state.userList?[index].isPending ?? 0;

                                      //     // Toggle the boolean flag
                                      //     isPending == 0 ? false : true;

                                      //     // Change the switch color based on the flag
                                      //     setState(() {
                                      //       isToggled =
                                      //           isPending == 0 ? true : false;
                                      //     });

                                      //     // Call the userFlag function if the flag is true
                                      //     if (isPending == 1) {
                                      //       context
                                      //           .read<AuthCubit>()
                                      //           .userFlag(userId);
                                      //     }

                                      //     // Rest of your code for handling the switch
                                      //     print(userId);
                                      //     print(state.userList?[index].isPending);
                                      //   },
                                      // )

                                      Switch(
                                        onChanged: (value) {
                                          BlocProvider.of<AuthCubit>(context)
                                              .userFlag(state.userList, index,
                                                  context);
                                        },
                                        value:
                                            state.userList?[index].isPending ==
                                                0,
                                        activeColor:
                                            state.userList?[index].isPending ==
                                                    0
                                                ? Colors.blue
                                                : Colors.white,
                                        activeTrackColor: Color(0xffC1C1C1),
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Color(0xffC1C1C1),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                ],
              ),
            );
          },
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
                      //  Navigator.pushNamed(context, budgetreport);
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
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "User Roles",
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

  Widget showPopup(context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 80,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Globals.kTextFieldFilledColor,
      content: Container(
          padding: const EdgeInsetsDirectional.all(10),
          color: Colors.white,

          ///  alignment: Alignment.center,
          width: Globals.getDeviceWidth(context),
          height: isLandscape(context)
              ? Globals.getDeviceHeight(context) * 0.5
              : Globals.getDeviceHeight(context) * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Material(
                  child: Text(
                "Select Report For View",
                style: TextStyle(
                  color: Color(0xff456BD0),
                  fontSize: 18,
                ),
              )),
              const SizedBox(
                height: 5,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [Color(0xff233C7E), Color(0xff456BD0)])),
                child: MaterialButton(
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: double.infinity,
                  onPressed: () => Navigator.pushNamed(context, budgetreport),
                  child: Text(
                    "Budget",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: Globals.getDeviceHeight(context) * 0.02,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Globals.kUniversalColor)),
                child: MaterialButton(
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: double.infinity,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Home(
                                selectedIndex: 2,
                              ))),
                  child: Text(
                    "Receipt",
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Globals.kUniversalColor,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          )),
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
  double size = 15;
  double innerPadding = 0;

  @override
  void initState() {
    setState(() {
      isToggled = BlocProvider.of<AuthCubit>(context).state.updateisPending == 0
          ? false
          : true;
    });

    innerPadding = size / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isPending =
        BlocProvider.of<AuthCubit>(context).state.updateisPending == 0;
    final switchColor = isPending ? Color(0xff888888) : Globals.kUniversalColor;
    final borderColor = isPending ? Color(0xff888888) : Globals.kUniversalColor;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled);
      },
      onPanEnd: (b) {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled);
      },
      child: Container(
        margin: EdgeInsets.only(left: isLandscape(context) ? 75 : 15),
        padding: EdgeInsets.all(14),
        width: isLandscape(context)
            ? Globals.getDeviceWidth(context) * 0.1
            : Globals.getDeviceWidth(context) * 0.17,
        height: Globals.getDeviceHeight(context) * 0.45,
        child: AnimatedContainer(
          height: size,
          width: size * 1.7,
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
              color: switchColor,
            ),
          ),
        ),
      ),
    );
  }
}
