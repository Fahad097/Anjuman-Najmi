import 'dart:io';
import 'package:anjuman_e_najmi/logic/cubit/access/access_cubit.dart';
import 'package:anjuman_e_najmi/logic/cubit/role/role_cubit.dart';
import 'package:anjuman_e_najmi/utils/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:anjuman_e_najmi/routes/custom_routes.dart';
import 'package:anjuman_e_najmi/logic/cubit/authentication/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/cubit/receipt/receipt_cubit.dart';
import 'logic/cubit/usermanaged/usermanaged_cubit.dart';

void main() async {
  await Globals.mainInit();
  runApp(const MyApp());

  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ReceiptCubit>(create: (context) => ReceiptCubit()),
        BlocProvider<UserManagedCubit>(create: (context) => UserManagedCubit()),
        BlocProvider<RoleCubit>(create: (context) => RoleCubit()),
        BlocProvider<AccessCubit>(create: (context) => AccessCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Anjuman-e-Najmi',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              elevation: 0.0, // This removes the shadow from all App Bars.
            ),
            textTheme: TextTheme(
              // caption:TextStyle(  fontFamily: 'Helvetica',),
              bodyMedium: TextStyle(
                fontFamily: 'Helvetica',
              ),
            ),
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: CustomRoutes.allRoutes,
          initialRoute: splash),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
