import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/authentication/auth_cubit.dart';
import '../../utils/asset_config.dart';
import '../../utils/global_constants.dart';
import '../../utils/landscape_mode.dart';
import 'components/asset_provider.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child:
                //  state.isloading!
                //     ? Center(
                //         child: CircularProgressIndicator(
                //             color: Globals.kUniversalColor))
                //     :
                Column(
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
                        //110
                        SizedBox(
                          height: Globals.getDeviceHeight(context) * 0.1,
                        ),
                        Text("Create Account",
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            )),
                        SizedBox(
                          //10
                          height: Globals.getDeviceHeight(context) * 0.06,
                        ),

                        Container(
                          padding: EdgeInsets.all(18),
                          width: Globals.getDeviceWidth(context),
                          height: isLandscape(context)
                              ? Globals.getDeviceHeight(context) * 1.0
                              : Globals.getDeviceHeight(context) * 0.76,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Form(
                            key: formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Sign Up",
                                      style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        color: Globals.ktitleColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    height:
                                        Globals.getDeviceHeight(context) * 0.01,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'FullName is required';
                                      }
                                      if (value.trim().length > 25) {
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
                                            .fullName(value)
                                        : print("$value"),
                                    decoration: InputDecoration(
                                      //focusColor: const Color(0xffE4F9E8),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      // filled: true,
                                      hintText: "FullName",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Helvetica',
                                        color: Globals.kFiledColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      contentPadding: EdgeInsets.all(17),
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'User Name is required';
                                      }
                                      if (value.trim().length > 26) {
                                        return 'Dont Exceed the text Limit';
                                      }
                                      // Return null if the entered password is valid
                                      return null;
                                    },
                                    onChanged: (value) => value.isNotEmpty &&
                                            value != '' &&
                                            value.trim().length <= 26
                                        ? context
                                            .read<AuthCubit>()
                                            .username(value)
                                        : print("$value"),
                                    decoration: InputDecoration(
                                      // focusColor: const Color(0xffE4F9E8),
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
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Email is required";
                                      }
                                      if (!emailRegex.hasMatch(val)) {
                                        return "Invalid Email";
                                      }
                                      return null;
                                    },
                                    onChanged: (val) => emailRegex.hasMatch(val)
                                        ? context.read<AuthCubit>().email(val)
                                        : null,
                                    decoration: InputDecoration(
                                      // focusColor: const Color(0xffE4F9E8),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      // filled: true,
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Helvetica',
                                        color: Globals.kFiledColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      contentPadding: EdgeInsets.all(17),
                                    ),
                                  ),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Password is required';
                                      }
                                      if (value.trim().length > 8) {
                                        return 'Dont Exceed the Password no Limit';
                                      }
                                      // Return null if the entered password is valid
                                      return null;
                                    },
                                    onChanged: (value) => value.isNotEmpty &&
                                            int.parse(value) != 0 &&
                                            value.trim().length <= 8
                                        ? context
                                            .read<AuthCubit>()
                                            .password(value)
                                        : print("$value"),
                                    decoration: InputDecoration(
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
                                    height:
                                        Globals.getDeviceHeight(context) * 0.05,
                                  ),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<AuthCubit>(context)
                                              .signup(context);
                                        }
                                      },
                                      child: (state.isloading!)
                                          ? CircularProgressIndicator()
                                          : Text(
                                              "Sign up",
                                              style: TextStyle(
                                                  fontFamily: 'Helvetica',
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                    ),
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Already have an account?",
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        //color: Color(0xff202A44),
                        color: Globals.kbottomtextColor, fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, signIn),
                    child: Text("SignIn",
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          color: Globals.kUniversalColor,
                          // color: Color(0xff202A44),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
