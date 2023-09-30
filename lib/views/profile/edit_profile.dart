import 'package:anjuman_e_najmi/logic/cubit/authentication/auth_cubit.dart';
import 'package:anjuman_e_najmi/logic/cubit/role/role_state.dart';
import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:anjuman_e_najmi/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/user_model.dart';
import '../../logic/cubit/role/role_cubit.dart';
import '../../utils/asset_config.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';
import '../authentication/components/asset_provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key, this.btncheck, this.userModel});
  final String? btncheck;
  final UserModel? userModel;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

final GlobalKey<FormState> editKey = GlobalKey<FormState>();

class _EditProfileState extends State<EditProfile> {
  bool isloading = false;
  _loadData() async {
    BlocProvider.of<AuthCubit>(context).state.password = '';
    widget.btncheck == "GetUserEdit"
        ? await BlocProvider.of<RoleCubit>(context).getUserRole(context)
        : SizedBox();

    if (widget.btncheck == "GetUserEdit") {
      await BlocProvider.of<AuthCubit>(context)
          .updateemail(widget.userModel?.email ?? "");
      await BlocProvider.of<AuthCubit>(context)
          .updatefullName(widget.userModel?.fullname ?? "");
      await BlocProvider.of<AuthCubit>(context)
          .updateusername(widget.userModel?.username ?? "");
      await BlocProvider.of<AuthCubit>(context)
          .updateroleId(widget.userModel?.roleId ?? 0);
      BlocProvider.of<AuthCubit>(context).state.updatepassword = '';
    }

    setState(() {
      isloading = true;
    });
  }

  @override
  void initState() {
    _loadData();
    BlocProvider.of<AuthCubit>(context)
        .password(BlocProvider.of<AuthCubit>(context).getUserPassword);
    print(BlocProvider.of<AuthCubit>(context).getUserPassword);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: widget.btncheck == "GetUserEdit"
            ? BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final authCub =
                      BlocProvider.of<AuthCubit>(context, listen: false);
                  return SingleChildScrollView(
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
                                  onPressed: () => Navigator.pop(context),
                                ),
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
                                                    asset:
                                                        "assets/user_icon.png",
                                                    width: 20,
                                                    height: 20,
                                                    color: Color(0xff717171)),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text("User",
                                                    style: TextStyle(
                                                      fontFamily: 'Helvetica',
                                                      color: Globals
                                                          .kUniversalColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                              ],
                                            )),
                                      ];
                                    },
                                    onSelected: (value) {
                                      if (value == 0) {
                                        context.read<AuthCubit>().getUser(
                                            context, widget.userModel?.id ?? 0);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Profile(
                                                      btncheck: "GetUser",
                                                      userModel:
                                                          widget.userModel,
                                                    )));
                                      }
                                    })
                              ]),
                        ),
                        Padding(
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
                                  Text("UserEditProfile",
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    //50
                                    height:
                                        Globals.getDeviceHeight(context) * 0.03,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(20),
                                      width: Globals.getDeviceWidth(context),
                                      height: isLandscape(context)
                                          ? Globals.getDeviceHeight(context) *
                                              1.0
                                          : Globals.getDeviceHeight(context) *
                                              0.75,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: (isloading == false)
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Form(
                                              key: editKey,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: Globals
                                                              .getDeviceHeight(
                                                                  context) *
                                                          0.05,
                                                    ),
                                                    editRowtext(
                                                        context,
                                                        "Name:",
                                                        Globals
                                                            .isTextNullOrEmptyString(
                                                                widget.userModel
                                                                    ?.fullname),
                                                        (value) => context
                                                            .read<AuthCubit>()
                                                            .updatefullName(
                                                                value),
                                                        (value) {
                                                      if (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'Name is required';
                                                      }
                                                      if (value.trim().length >
                                                          30) {
                                                        return 'Dont Exceed the text Limit';
                                                      }
                                                      return null;
                                                    }
                                                        // "Marcel"

                                                        ),
                                                    editRowtext(
                                                        context,
                                                        "Username:",
                                                        Globals.isTextNullOrEmptyString(
                                                            widget.userModel
                                                                    ?.username ??
                                                                ""),
                                                        (value) => value
                                                                    .isNotEmpty &&
                                                                value != "" &&
                                                                value
                                                                        .trim()
                                                                        .length <=
                                                                    25
                                                            ? context
                                                                .read<
                                                                    AuthCubit>()
                                                                .updateusername(
                                                                    value)
                                                            : print("$value"),
                                                        //"John Deo"
                                                        (value) {
                                                      if (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'UserName is required';
                                                      }
                                                      if (value.trim().length >
                                                          25) {
                                                        return 'Dont Exceed the text Limit';
                                                      }
                                                      return null;
                                                    }),
                                                    editRowtext(
                                                        context,
                                                        "Email:",
                                                        Globals
                                                            .isTextNullOrEmptyString(
                                                                widget.userModel
                                                                        ?.email ??
                                                                    ""),
                                                        (value) => value
                                                                    .isNotEmpty &&
                                                                value != "" &&
                                                                value
                                                                        .trim()
                                                                        .length <=
                                                                    35
                                                            ? context
                                                                .read<
                                                                    AuthCubit>()
                                                                .updateusername(
                                                                    value)
                                                            : print("$value")
                                                        // "marcel23@gmail.com",
                                                        , (value) {
                                                      if (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'Email is required';
                                                      }
                                                      if (value.trim().length >
                                                          35) {
                                                        return 'Dont Exceed the text Limit';
                                                      }
                                                      return null;
                                                    }),
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: Globals
                                                                        .getDeviceWidth(
                                                                            context) *
                                                                    0.3,
                                                                child: Text(
                                                                    "Password: ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Helvetica',
                                                                      color: Color(
                                                                          0xff676767),
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    )),
                                                              ),
                                                              SizedBox(
                                                                width: Globals
                                                                        .getDeviceWidth(
                                                                            context) *
                                                                    0.45,
                                                                child: TextFormField(
                                                                    textAlignVertical: TextAlignVertical.top,
                                                                    decoration: InputDecoration(
                                                                        //  contentPadding: EdgeInsets.only(bottom: 0),
                                                                        isDense: true,
                                                                        alignLabelWithHint: true),
                                                                    onChanged: (value) {
                                                                      context
                                                                          .read<
                                                                              AuthCubit>()
                                                                          .updatepassword(
                                                                              value);
                                                                    },
                                                                    style: TextStyle(
                                                                      fontFamily:
                                                                          'Helvetica',
                                                                      color: Globals
                                                                          .kUniversalColor,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: Globals
                                                                    .getDeviceHeight(
                                                                        context) *
                                                                0.03,
                                                          ),
                                                          editRowDropDown(
                                                              context,
                                                              "Role",
                                                              widget.userModel
                                                                      ?.roleId ??
                                                                  0),
                                                          SizedBox(
                                                            height: Globals
                                                                    .getDeviceHeight(
                                                                        context) *
                                                                0.03,
                                                          ),
                                                          DecoratedBox(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                gradient:
                                                                    LinearGradient(
                                                                        colors: [
                                                                      Color(
                                                                          0xff233C7E),
                                                                      Color(
                                                                          0xff456BD0)
                                                                    ])),
                                                            child:
                                                                MaterialButton(
                                                              height: 50,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              minWidth: double
                                                                  .infinity,
                                                              onPressed:
                                                                  () async {
                                                                if (editKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  await context
                                                                      .read<
                                                                          AuthCubit>()
                                                                      .editUserProfile(
                                                                          context,
                                                                          widget.userModel?.id ??
                                                                              0);
                                                                }
                                                              },
                                                              child: (state
                                                                          .isloading ??
                                                                      false)
                                                                  ? CircularProgressIndicator()
                                                                  : Text(
                                                                      "UpdateUser",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Helvetica',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                            ),
                                                          ),
                                                        ]),
                                                  ]),
                                            ))
                                ]))
                      ])
                    ]),
                  );
                },
              )
            : BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final authCub =
                      BlocProvider.of<AuthCubit>(context, listen: false);
                  return SingleChildScrollView(
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
                                  onPressed: () => Navigator.pop(context),
                                ),
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
                                                    asset:
                                                        "assets/user_icon.png",
                                                    width: 20,
                                                    height: 20,
                                                    color: Color(0xff717171)),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text("Profile",
                                                    style: TextStyle(
                                                      fontFamily: 'Helvetica',
                                                      color: Globals
                                                          .kUniversalColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                              ],
                                            )),
                                      ];
                                    },
                                    onSelected: (value) {
                                      if (value == 1) {
                                        context.read<AuthCubit>().getProfile(
                                            context, authCub.getuserID);
                                        Navigator.pushNamed(context, profile);
                                      }
                                    })
                              ]),
                        ),
                        Padding(
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
                                  Text("EditProfile",
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    //50
                                    height:
                                        Globals.getDeviceHeight(context) * 0.03,
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
                                    child: (isloading == false)
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Form(
                                            key: editKey,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  //  imageProfile(context, state),
                                                  SizedBox(
                                                    height:
                                                        Globals.getDeviceHeight(
                                                                context) *
                                                            0.05,
                                                  ),
                                                  editRowtext(
                                                      context,
                                                      "Name:",
                                                      Globals
                                                          .isTextNullOrEmptyString(
                                                              authCub.state
                                                                  .fullname),
                                                      (value) => value
                                                                  .isNotEmpty &&
                                                              value != "" &&
                                                              value
                                                                      .trim()
                                                                      .length <=
                                                                  30
                                                          ? context
                                                              .read<AuthCubit>()
                                                              .fullName(value)
                                                          : print("$value")
                                                      // "Marcel"
                                                      , (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Name is required';
                                                    }
                                                    if (value.trim().length >
                                                        30) {
                                                      return 'Dont Exceed the text Limit';
                                                    }
                                                    return null;
                                                  }),
                                                  editRowtext(
                                                      context,
                                                      "Username:",
                                                      Globals
                                                          .isTextNullOrEmptyString(
                                                              authCub.state
                                                                      .username ??
                                                                  ""),
                                                      (value) => value
                                                                  .isNotEmpty &&
                                                              value != "" &&
                                                              value
                                                                      .trim()
                                                                      .length <=
                                                                  25
                                                          ? context
                                                              .read<AuthCubit>()
                                                              .username(value)
                                                          : print("$value")
                                                      //"John Deo"
                                                      , (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'UserName is required';
                                                    }
                                                    if (value.trim().length >
                                                        25) {
                                                      return 'Dont Exceed the text Limit';
                                                    }
                                                    return null;
                                                  }),
                                                  editRowtext(
                                                      context,
                                                      "Email:",
                                                      Globals
                                                          .isTextNullOrEmptyString(
                                                              authCub
                                                                  .state.email),
                                                      (value) => value
                                                                  .isNotEmpty &&
                                                              value != "" &&
                                                              value
                                                                      .trim()
                                                                      .length <=
                                                                  30
                                                          ? context
                                                              .read<AuthCubit>()
                                                              .email(value)
                                                          : print("$value")
                                                      // "marcel23@gmail.com"
                                                      , (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Email is required';
                                                    }
                                                    if (value.trim().length >
                                                        30) {
                                                      return 'Dont Exceed the text Limit';
                                                    }
                                                    return null;
                                                  }),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: Globals
                                                                    .getDeviceWidth(
                                                                        context) *
                                                                0.3,
                                                            child: Text(
                                                                "Password: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Helvetica',
                                                                  color: Color(
                                                                      0xff676767),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                          ),
                                                          SizedBox(
                                                            width: Globals
                                                                    .getDeviceWidth(
                                                                        context) *
                                                                0.45,
                                                            child: TextFormField(
                                                                textAlignVertical: TextAlignVertical.top,
                                                                decoration: InputDecoration(
                                                                    //  contentPadding: EdgeInsets.only(bottom: 0),
                                                                    isDense: true,
                                                                    alignLabelWithHint: true),
                                                                onChanged: (value) {
                                                                  context
                                                                      .read<
                                                                          AuthCubit>()
                                                                      .password(
                                                                          value);
                                                                },
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                      'Helvetica',
                                                                  color: Globals
                                                                      .kUniversalColor,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: Globals
                                                                .getDeviceHeight(
                                                                    context) *
                                                            0.03,
                                                      )
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height:
                                                        Globals.getDeviceHeight(
                                                                context) *
                                                            0.03,
                                                  ),
                                                  DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        gradient:
                                                            LinearGradient(
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
                                                      onPressed: () async {
                                                        if (editKey
                                                            .currentState!
                                                            .validate()) {
                                                          await context
                                                              .read<AuthCubit>()
                                                              .editProfile(
                                                                  context,
                                                                  authCub
                                                                      .getuserID);
                                                          Navigator.pop(
                                                              context);
                                                          context
                                                              .read<AuthCubit>()
                                                              .getProfile(
                                                                  context,
                                                                  authCub
                                                                      .getuserID);
                                                        }
                                                      },
                                                      child: (state.isloading ??
                                                              false)
                                                          ? CircularProgressIndicator()
                                                          : Text(
                                                              "Update",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Helvetica',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                  )
                                ]))
                      ])
                    ]),
                  );
                },
              ));
  }

  Widget editRowDropDown(context, String title, int role) {
    return BlocBuilder<RoleCubit, RoleState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                SizedBox(
                  width: Globals.getDeviceWidth(context) * 0.3,
                  child: Text(title,
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        color: Color(0xff676767),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  width: Globals.getDeviceWidth(context) * 0.45,
                  child: DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      hint: Text("Select User Role"),
                      value: role,
                      icon: ImageIcon(
                        AssetImage(AssetConfig.kdropdownIcon),
                        color: Colors.grey,
                        size: 16,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(13),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          fillColor: Globals.kFiledColor),
                      validator: (value) =>
                          value == null ? "User Role is required" : null,
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        color: Color(0xff6D6D6D),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      onChanged: (value) => value != null && value != 0
                          ? context.read<AuthCubit>().updateroleId(value)
                          : print("$value"),
                      items: state.userRole?.map((item) {
                        return DropdownMenuItem(
                          value: item.id,
                          child: Visibility(child: Text(item.name.toString())),
                        );
                      }).toList()),
                ),
              ],
            ),
            SizedBox(
              height: Globals.getDeviceHeight(context) * 0.03,
            )
          ],
        );
      },
    );
  }

  Widget editRowtext(context, String title, String detail,
      Function(String) onChanged, String? Function(String?) validator) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            SizedBox(
              width: Globals.getDeviceWidth(context) * 0.3,
              child: Text(title,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Color(0xff676767),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            SizedBox(
              width: Globals.getDeviceWidth(context) * 0.45,
              child: TextFormField(
                  initialValue: detail,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      //  contentPadding: EdgeInsets.only(bottom: 0),
                      isDense: true,
                      alignLabelWithHint: true),
                  onChanged: onChanged,
                  validator: validator,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Globals.kUniversalColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
            )
          ],
        ),
        SizedBox(
          height: Globals.getDeviceHeight(context) * 0.03,
        )
      ],
    );
  }
}
