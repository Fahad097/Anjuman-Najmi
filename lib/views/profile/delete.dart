import 'package:anjuman_e_najmi/logic/cubit/authentication/auth_cubit.dart';
import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../utils/asset_config.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';
import '../authentication/components/asset_provider.dart';

class Delete extends StatelessWidget {
  const Delete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // appBar: AppBar(
        //   elevation: 0.0,
        //   actions: [
        //     PopupMenuButton(
        //         padding: EdgeInsets.all(5),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.only(
        //             bottomLeft: Radius.circular(20.0),
        //             bottomRight: Radius.circular(20.0),
        //             topLeft: Radius.circular(20.0),
        //             topRight: Radius.circular(0),
        //           ),
        //         ),
        //         icon: ImageIcon(AssetImage(AssetConfig.kMoreIcon)),
        //         itemBuilder: (context) {
        //           return [
        //             PopupMenuItem<int>(
        //                 value: 0,
        //                 child: Row(
        //                   children: [
        //                     AssetProvider(
        //                         asset: AssetConfig.kreadwrite_Icon,
        //                         width: 20,
        //                         height: 20,
        //                         color: Color(0xff717171)),
        //                     SizedBox(
        //                       width: 3,
        //                     ),
        //                     Text("Edit Profile",
        //                         style: TextStyle(
        //                           fontFamily: 'Helvetica',
        //                           color: Globals.kUniversalColor,
        //                           fontWeight: FontWeight.w400,
        //                         )),
        //                   ],
        //                 )),
        //             PopupMenuItem<int>(
        //                 value: 1,
        //                 child: Row(
        //                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     AssetProvider(
        //                         asset: "assets/user_icon.png",
        //                         width: 20,
        //                         height: 20,
        //                         color: Color(0xff717171)),
        //                     SizedBox(
        //                       width: 3,
        //                     ),
        //                     Text("Profile",
        //                         style: TextStyle(
        //                           fontFamily: 'Helvetica',
        //                           color: Globals.kUniversalColor,
        //                           fontWeight: FontWeight.w400,
        //                         )),
        //                   ],
        //                 )),
        //           ];
        //         },
        //         onSelected: (value) {
        //           if (value == 0) {
        //             Navigator.pushNamed(context, editprofile);
        //           } else if (value == 1) {
        //             Navigator.pushNamed(context, profile);
        //           } else if (value == 2) {
        //             print("Logout menu is selected.");
        //           }
        //         })
        //   ],
        //   backgroundColor: Colors.transparent,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ),

        backgroundColor: Color(0xffF5F5F5),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
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
                                            asset: AssetConfig.kreadwrite_Icon,
                                            width: 20,
                                            height: 20,
                                            color: Color(0xff717171)),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text("Edit Profile",
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
                              ];
                            },
                            onSelected: (value) {
                              if (value == 0) {
                                Navigator.pushNamed(context, editprofile);
                              } else if (value == 1) {
                                Navigator.pushNamed(context, profile);
                              } else if (value == 2) {
                                print("Logout menu is selected.");
                              }
                            })
                      ],
                    ),
                  ),
                  Padding(
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
                            Text("Delete Account",
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
                            SingleChildScrollView(
                                child: Container(
                              padding: EdgeInsets.all(20),
                              width: Globals.getDeviceWidth(context),
                              height: isLandscape(context)
                                  ? Globals.getDeviceHeight(context) * 0.9
                                  : Globals.getDeviceHeight(context) * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: Globals.getDeviceHeight(context) *
                                          0.04,
                                    ),
                                    Text("Account",
                                        style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          color: Globals.kFiledColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    SizedBox(
                                      height: Globals.getDeviceHeight(context) *
                                          0.03,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Username is required";
                                        }
                                        return val;
                                      },
                                      onChanged: (val) {},
                                      decoration: InputDecoration(
                                        // focusColor: const Color(0xffE4F9E8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),

                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                          fontFamily: 'Helvetica',
                                          color: Globals.kFiledColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        contentPadding: EdgeInsets.all(17),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Globals.getDeviceHeight(context) *
                                          0.03,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Password is required";
                                        }
                                        return val;
                                      },
                                      onChanged: (val) {},
                                      decoration: InputDecoration(
                                        // focusColor: const Color(0xffE4F9E8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),

                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          fontFamily: 'Helvetica',
                                          color: Globals.kFiledColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        contentPadding: EdgeInsets.all(17),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Globals.getDeviceHeight(context) *
                                          0.08,
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
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  verificationotpDialog(
                                                      context));
                                        },
                                        child: Text(
                                          "Delete Account",
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ))
                          ]))
                ])
              ]),
            );
          },
        ));
  }

  Widget verificationotpDialog(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: AlertDialog(
              insetPadding: EdgeInsets.only(
                  left: isLandscape(context) ? 90 : 15,
                  right: isLandscape(context) ? 90 : 15,
                  top: isLandscape(context) ? 20 : 160,
                  bottom: 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              shadowColor: Globals.kTextFieldFilledColor,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: Globals.getDeviceHeight(context) * 0.02,
                  ),
                  Text("Verification",
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        color: Color(0xff233C7E),
                        // Color(0xff202A44),
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      )),
                  SizedBox(
                    height: Globals.getDeviceHeight(context) * 0.02,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet consectetur. Nec sit adipiscing justo mi amet. Varius et et quis viverra nec.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Globals.getDeviceHeight(context) * 0.03,
                  ),
                  PinCodeTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    textStyle: TextStyle(
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4C74DE)),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please Enter Code";
                      } else if (val.length < 4) {
                        return "Enter Correct OTP";
                      }
                      return val;
                    },
                    //   Color(0xff4C74DE)
                    appContext: context,
                    length: 5,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      inactiveColor: Globals.kTextFieldFilledColor,
                      activeColor: Color(0xff4C74DE),
                      inactiveFillColor: Globals.kTextFieldFilledColor,
                      selectedColor: Color(0xff4C74DE),
                      selectedFillColor: Globals.kTextFieldFilledColor,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                  // Text(state.otpErro!,
                  //     style: TextStyle(  fontFamily: 'Helvetica',
                  //       color: Colors.red,
                  //       //fontSize: 12,
                  //       fontWeight: FontWeight.w400,
                  //     )),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text("Resend?",
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                color: Color(0xff4C74DE),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ))),
                      Spacer(),
                      Text("00",
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                Globals.popupDialog(context, () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, signIn, (route) => false);
                                }, () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }, "Are you sure you want to Delete Account?"));
                      },
                      child: Text(
                        "verify",
                        style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
