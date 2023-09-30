import 'package:anjuman_e_najmi/data/model/permission.dart';
import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:anjuman_e_najmi/views/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/user_model.dart';
import '../../logic/cubit/authentication/auth_cubit.dart';
import '../../utils/asset_config.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';
import '../authentication/components/asset_provider.dart';

class Profile extends StatelessWidget {
  Profile({super.key, this.i, this.btncheck, this.userModel});
  final int? i;
  final String? btncheck;
  final UserModel? userModel;
  bool hasWrite = permissionService.hasWritePermission('app.user');

  @override
  Widget build(BuildContext context) {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(children: [
              AssetProvider(
                asset: AssetConfig.kSignInPageImage,
                height: isLandscape(context)
                    ? Globals.getDeviceHeight(context) * 0.85
                    : Globals.getDeviceHeight(context) * 0.7,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: isLandscape(context)
                        ? Globals.getDeviceHeight(context) * 0.065
                        : Globals.getDeviceHeight(context) * 0.035),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () async {
                        if (btncheck == "GetUser") {
                          context.read<AuthCubit>().getAllUser(context);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    if (hasWrite)
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
                                          asset: AssetConfig.kreadwrite_Icon,
                                          width: 20,
                                          height: 20,
                                          color: Color(0xff717171)),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text("EditProfile",
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
                            if (value == 1) {
                              if (btncheck == "GetUser") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => EditProfile(
                                            btncheck: "GetUserEdit",
                                            userModel: userModel)));
                              } else {
                                Navigator.pushNamed(context, editprofile);
                              }
                            }
                          })
                  ],
                ),
              ),
              btncheck == "GetUser"
                  ? BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    //50
                                    height: isLandscape(context)
                                        ? Globals.getDeviceHeight(context) *
                                            0.22
                                        : Globals.getDeviceHeight(context) *
                                            0.12,
                                  ),
                                  Text("User",
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    height:
                                        Globals.getDeviceHeight(context) * 0.04,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    width: Globals.getDeviceWidth(context),
                                    height: isLandscape(context)
                                        ? Globals.getDeviceHeight(context) * 1.0
                                        : Globals.getDeviceHeight(context) *
                                            0.68,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: (userModel?.roleName == '')
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                                SizedBox(
                                                  height:
                                                      Globals.getDeviceHeight(
                                                              context) *
                                                          0.04,
                                                ),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Color(0xffE6E6E6),
                                                      radius: 25,
                                                      child: Icon(
                                                        Icons.person,
                                                        color:
                                                            Color(0xffCCCCCC),
                                                        size: 24,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Globals
                                                              .getDeviceWidth(
                                                                  context) *
                                                          0.09,
                                                    ),
                                                    Text(
                                                        Globals
                                                            .isTextNullOrEmptyString(
                                                                userModel
                                                                    ?.fullname),
                                                        //"Marcel galliard",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Helvetica',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xff666666),
                                                            fontSize: 24)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      Globals.getDeviceHeight(
                                                              context) *
                                                          0.03,
                                                ),
                                                profileRowtext(
                                                    context,
                                                    "Role: ",
                                                    Globals
                                                        .isTextNullOrEmptyString(
                                                            userModel
                                                                ?.roleName)),
                                                profileRowtext(
                                                    context,
                                                    "Email: ",
                                                    Globals
                                                        .isTextNullOrEmptyString(
                                                            userModel?.email)),
                                                SizedBox(
                                                  height:
                                                      Globals.getDeviceHeight(
                                                              context) *
                                                          0.03,
                                                ),
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Globals
                                                              .kUniversalColor)),
                                                  child: MaterialButton(
                                                    height: 50,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    minWidth: double.infinity,
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  EditProfile(
                                                                      btncheck:
                                                                          "GetUserEdit",
                                                                      userModel:
                                                                          userModel)));
                                                    },
                                                    child: Text(
                                                      "Edit Profile",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Helvetica',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Globals
                                                              .kUniversalColor,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      Globals.getDeviceHeight(
                                                              context) *
                                                          0.02,
                                                ),
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Color(0xff233C7E),
                                                            Color(0xff456BD0)
                                                          ])),
                                                  child: MaterialButton(
                                                    height: 50,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    minWidth: double.infinity,
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              Globals.deleteAccount(
                                                                  context,
                                                                  () => context
                                                                      .read<
                                                                          AuthCubit>()
                                                                      .deleteUserAccount(
                                                                          context,
                                                                          userModel?.id ??
                                                                              0),
                                                                  () => Navigator
                                                                      .pop(
                                                                          context)));
                                                    },
                                                    child: Text(
                                                      "Delete Account",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Helvetica',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                  )
                                ]));
                      },
                    )
                  : BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    //50
                                    height: isLandscape(context)
                                        ? Globals.getDeviceHeight(context) *
                                            0.22
                                        : Globals.getDeviceHeight(context) *
                                            0.14,
                                  ),
                                  Text("Profile",
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    height:
                                        Globals.getDeviceHeight(context) * 0.04,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    width: Globals.getDeviceWidth(context),
                                    height: isLandscape(context)
                                        ? Globals.getDeviceHeight(context) * 1.0
                                        : Globals.getDeviceHeight(context) *
                                            0.68,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: (state.roleName == '')
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                                SizedBox(
                                                  height:
                                                      Globals.getDeviceHeight(
                                                              context) *
                                                          0.04,
                                                ),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Color(0xffE6E6E6),
                                                      radius: 25,
                                                      child: Icon(
                                                        Icons.person,
                                                        color:
                                                            Color(0xffCCCCCC),
                                                        size: 24,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Globals
                                                              .getDeviceWidth(
                                                                  context) *
                                                          0.09,
                                                    ),
                                                    Text(
                                                        Globals
                                                            .isTextNullOrEmptyString(
                                                                state.fullname),
                                                        //"Marcel galliard",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Helvetica',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xff666666),
                                                            fontSize: 24)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      Globals.getDeviceHeight(
                                                              context) *
                                                          0.03,
                                                ),
                                                profileRowtext(
                                                    context,
                                                    "Role: ",
                                                    Globals
                                                        .isTextNullOrEmptyString(
                                                            state.roleName)),
                                                profileRowtext(
                                                    context,
                                                    "Email: ",
                                                    Globals
                                                        .isTextNullOrEmptyString(
                                                            state.email)),
                                                SizedBox(
                                                  height:
                                                      Globals.getDeviceHeight(
                                                              context) *
                                                          0.03,
                                                ),
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Globals
                                                              .kUniversalColor)),
                                                  child: MaterialButton(
                                                    height: 50,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    minWidth: double.infinity,
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context, editprofile);
                                                    },
                                                    child: Text(
                                                      "Edit Profile",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Helvetica',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Globals
                                                              .kUniversalColor,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      Globals.getDeviceHeight(
                                                              context) *
                                                          0.02,
                                                ),
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Color(0xff233C7E),
                                                            Color(0xff456BD0)
                                                          ])),
                                                  child: MaterialButton(
                                                    height: 50,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    minWidth: double.infinity,
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              Globals.deleteAccount(
                                                                  context,
                                                                  () => context
                                                                      .read<
                                                                          AuthCubit>()
                                                                      .deleteAccount(
                                                                          context,
                                                                          authCub
                                                                              .getuserID),
                                                                  () => Navigator
                                                                      .pop(
                                                                          context)));
                                                    },
                                                    child: Text(
                                                      "Delete Account",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Helvetica',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                  )
                                ]));
                      },
                    )
            ])
          ]),
        ));
  }

  Widget profileRowtext(context, String title, String detail) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              SizedBox(
                width: Globals.getDeviceWidth(context) * 0.2,
                child: Text(title,
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Color(0xff666666),
                        fontSize: 16)),
              ),
              SizedBox(
                width: Globals.getDeviceWidth(context) * 0.35,
                child: Text(detail,
                    style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Globals.kUniversalColor,
                        fontSize: 16)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Globals.getDeviceHeight(context) * 0.04,
        ),
      ],
    );
  }
}
