import 'dart:io';
import 'package:anjuman_e_najmi/logic/cubit/authentication/auth_cubit.dart';
import 'package:anjuman_e_najmi/logic/cubit/role/role_state.dart';
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

class AddUser extends StatefulWidget {
  AddUser({super.key, this.userModel});
  final UserModel? userModel;
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  ImagePicker _picker = ImagePicker();
  //File? image;
  @override
  void initState() {
    BlocProvider.of<RoleCubit>(context).getUserRole(context);
    super.initState();
  }

  final GlobalKey<FormState> addKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
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
                                              asset: "assets/user_icon.png",
                                              width: 20,
                                              height: 20,
                                              color: Color(0xff717171)),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text("User",
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
                                      .getUser(context, authCub.getuserID);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Profile(
                                              btncheck: "GetUser",
                                              userModel: widget.userModel)));
                                }
                              })
                        ]),
                  ),
                  Form(
                    key: addKey,
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                //50
                                height: isLandscape(context)
                                    ? Globals.getDeviceHeight(context) * 0.22
                                    : Globals.getDeviceHeight(context) * 0.14,
                              ),
                              Text("Add User",
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  )),
                              SizedBox(
                                //50
                                height: Globals.getDeviceHeight(context) * 0.03,
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                width: Globals.getDeviceWidth(context),
                                height: isLandscape(context)
                                    ? Globals.getDeviceHeight(context) * 1.0
                                    : Globals.getDeviceHeight(context) * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //   imageProfile(context, state),
                                      SizedBox(
                                        height:
                                            Globals.getDeviceHeight(context) *
                                                0.03,
                                      ),
                                      editRowtext(
                                          context,
                                          "Name:",
                                          "",
                                          (value) => value.isNotEmpty &&
                                                  value != "" &&
                                                  value.trim().length <= 30
                                              ? context
                                                  .read<AuthCubit>()
                                                  .updatefullName(value)
                                              : print("$value")
                                          // "Marcel"
                                          , (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'FullName is required';
                                        }
                                        if (value.trim().length > 30) {
                                          return 'Dont Exceed the text Limit';
                                        }
                                        return null;
                                      }),

                                      editRowtext(
                                          context,
                                          "Username:",
                                          "",
                                          (value) => value.isNotEmpty &&
                                                  value != "" &&
                                                  value.trim().length <= 30
                                              ? context
                                                  .read<AuthCubit>()
                                                  .updateusername(value)
                                              : print("$value")
                                          //"John Deo"
                                          , (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'UserName is required';
                                        }
                                        if (value.trim().length > 30) {
                                          return 'Dont Exceed the text Limit';
                                        }
                                        return null;
                                      }),
                                      editRowtext(
                                          context,
                                          "Password:",
                                          "",
                                          (value) => value.isNotEmpty &&
                                                  value != "" &&
                                                  value.trim().length <= 8
                                              ? context
                                                  .read<AuthCubit>()
                                                  .updatepassword(value)
                                              : print("$value")
                                          // "marcel23@gmail.com"
                                          , (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Password is required';
                                        }
                                        if (value.trim().length > 8) {
                                          return 'Dont Exceed the text Limit';
                                        }
                                        return null;
                                      }),

                                      editRowtext(
                                          context,
                                          "Email:",
                                          "",
                                          (value) => value.isNotEmpty &&
                                                  value != "" &&
                                                  value.trim().length <= 40
                                              ? context
                                                  .read<AuthCubit>()
                                                  .updateemail(value)
                                              : print("$value")
                                          // "marcel23@gmail.com"
                                          , (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Email is required';
                                        }
                                        if (value.trim().length > 40) {
                                          return 'Dont Exceed the text Limit';
                                        }
                                        return null;
                                      }),
                                      editRowDropDown(context, "Role", "User"),

                                      SizedBox(
                                        height:
                                            Globals.getDeviceHeight(context) *
                                                0.03,
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(colors: [
                                              Color(0xff233C7E),
                                              Color(0xff456BD0)
                                            ])),
                                        child: MaterialButton(
                                          height: 50,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          minWidth: double.infinity,
                                          onPressed: () async {
                                            if (addKey.currentState!
                                                .validate()) {
                                              await context
                                                  .read<AuthCubit>()
                                                  .addUser(context);
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text(
                                            "Add User",
                                            style: TextStyle(
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ]),
                              )
                            ])),
                  )
                ])
              ]),
            );
          },
        ));
  }

  Widget editRowDropDown(context, String title, String role) {
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

  void takephoto(BuildContext context, ImageSource imageSource) async {
    final xFile = await _picker.pickImage(source: imageSource);
    context.read<AuthCubit>().image(xFile!);
  }

  Widget imageProfile(BuildContext context, AuthState state) {
    return Stack(children: [
      CircleAvatar(
        backgroundColor: Globals.kUniversalColor,
        radius: 50,
        backgroundImage:
            //  image == null ? Container() : Image.file(File(image!.path))
            state.imagefile == null
                ? AssetImage('assets/user.png') as ImageProvider
                : FileImage(
                    File(context.read<AuthCubit>().state.imagefile.path)),
      ),
      Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              takephoto(context, ImageSource.gallery);
            },
            child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xff233C7E), Color(0xff456BD0)]),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ))
    ]);
  }
}

Widget editRowDropDown(context, String title, String role) {
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
