import 'package:anjuman_e_najmi/utils/global_constants.dart';
import 'package:anjuman_e_najmi/utils/landscape_mode.dart';
import 'package:anjuman_e_najmi/views/authentication/signin.dart';
import 'package:flutter/material.dart';
import '../utils/asset_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushReplacementNamed(context, signIn);
      // context.read<AuthCubit>().getInfo();
      // context.read<AuthCubit>().getId();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => SignIn()), (route) => false);
    });

    //
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xff1A357C), Color(0xff547AE3)])),
        child: Center(
          child: Image.asset(
            AssetConfig.kLogo,
            height: isLandscape(context)
                ? Globals.getDeviceHeight(context) * 0.4
                : Globals.getDeviceHeight(context) * 0.23,
          ),
        ),
      ),
    );
  }
}
