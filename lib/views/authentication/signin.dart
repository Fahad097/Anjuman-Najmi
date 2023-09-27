import 'package:anjuman_e_najmi/logic/cubit/authentication/auth_cubit.dart';
import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:anjuman_e_najmi/utils/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/receipt/receipt_cubit.dart';
import '../../utils/asset_config.dart';
import '../../utils/landscape_mode.dart';
import 'components/asset_provider.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
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
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Globals.getDeviceHeight(context) * 0.1,
                          ),
                          Text("Login",
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: Globals.getDeviceHeight(context) * 0.06,
                          ),
                          Container(
                            padding: EdgeInsets.all(18),
                            width: Globals.getDeviceWidth(context),
                            height: isLandscape(context)
                                ? Globals.getDeviceHeight(context) * 0.8
                                : Globals.getDeviceHeight(context) * 0.66,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white),
                            child: Form(
                              key: formKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: Globals.getDeviceHeight(context) *
                                          0.05,
                                    ),
                                    Text("Sign In",
                                        style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          color: Globals.ktitleColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    SizedBox(
                                      height: Globals.getDeviceHeight(context) *
                                          0.04,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Username is required';
                                        }
                                        if (value.trim().length > 15) {
                                          return 'Dont Exceed the text Limit';
                                        }
                                        // Return null if the entered password is valid
                                        return null;
                                      },
                                      onChanged: (value) => value.isNotEmpty &&
                                              value != '' &&
                                              value.trim().length <= 25
                                          ? context
                                              .read<AuthCubit>()
                                              .username(value)
                                          : print("$value"),
                                      decoration: InputDecoration(
                                        //focusColor: const Color(0xffE4F9E8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // filled: true,
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
                                          0.025,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.number,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Password is required';
                                        }
                                        if (value.trim().length > 8) {
                                          return 'Dont Exceed the text Limit';
                                        }
                                        // Return null if the entered password is valid
                                        return null;
                                      },
                                      onChanged: (value) => value.isNotEmpty &&
                                              value != '' &&
                                              value.trim().length <= 8
                                          ? context
                                              .read<AuthCubit>()
                                              .password(value)
                                          : print("$value"),
                                      decoration: InputDecoration(
                                        // focusColor: const Color(0xffE4F9E8),

                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // filled: true,
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
                                        // color: Globals.kUniversalColor,
                                        onPressed: () {
                                          // showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) =>
                                          // VerificationDialog());
                                          // BlocProvider.of<AuthCubit>(context)
                                          //     .startTimer();
                                          if (formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<AuthCubit>()
                                                .signin(context);
                                            //  context.read<AuthCubit>().sigin();
                                            // context.read<AuthCubit>().createAlbum(
                                            //     state.name!, state.password!);
                                          }
                                        },
                                        child: Text(
                                          "Sign In",
                                          style: TextStyle(
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    // BlocBuilder<ReceiptCubit, ReceiptState>(
                                    //     builder: (context, state) {
                                    //   return Switch(
                                    //     onChanged: (value) {
                                    //       BlocProvider.of<ReceiptCubit>(context)
                                    //           .check(value);
                                    //       print(BlocProvider.of<ReceiptCubit>(
                                    //               context)
                                    //           .state
                                    //           .isCheck!);
                                    //     },
                                    //     value: BlocProvider.of<ReceiptCubit>(
                                    //             context)
                                    //         .state
                                    //         .isCheck!,
                                    //     activeColor: Colors.white,
                                    //     activeTrackColor: Color(0xffC1C1C1),
                                    //     inactiveThumbColor: Colors.white,
                                    //     inactiveTrackColor: Color(0xffC1C1C1),
                                    //   );
                                    // }),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Don’t have an account?",
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          color: Globals.kbottomtextColor,
                          // Color(0xff202A44),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, signUp);
                      },
                      child: Text("SignUp",
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Globals.kUniversalColor,
                            //  Color(0xff202A44),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ])
                ],
              ),
            );
          },
        ));
  }
}
