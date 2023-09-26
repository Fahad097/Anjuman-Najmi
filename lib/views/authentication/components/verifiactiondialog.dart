import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../logic/cubit/authentication/auth_cubit.dart';
import '../../../routes/routes_names.dart';
import '../../../utils/global_constants.dart';
import '../../../utils/landscape_mode.dart';

class VerificationDialog extends StatelessWidget {
  const VerificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: AlertDialog(
              insetPadding: EdgeInsets.only(
                  left: isLandscape(context) ? 90 : 15,
                  right: isLandscape(context) ? 90 : 15,
                  top: isLandscape(context) ? 30 : 160,
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
                          onPressed: () {
                          },
                          child: Text("Resend?",
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                color: Color(0xff4C74DE),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ))),
                      Spacer(),
                      Text(
                          "00",
                          //"00:59",
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Color(0xff727375),
                            fontSize: 14,
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, botttomnav, (route) => false);
                      },
                      //   Navigator.pushReplacementNamed(context, botttomnav),
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
