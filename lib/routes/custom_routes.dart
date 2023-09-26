import 'package:anjuman_e_najmi/views/home/home.dart';
import 'package:anjuman_e_najmi/views/receipt/addreceipt.dart';
import 'package:anjuman_e_najmi/views/setting/roles.dart';
import 'package:anjuman_e_najmi/views/setting/userrole.dart';
import 'package:anjuman_e_najmi/views/setting/rolesmanagement.dart';
import 'package:anjuman_e_najmi/views/splash.dart';
import 'package:anjuman_e_najmi/views/userManagement/adduser.dart';
import 'package:flutter/material.dart';
import '../views/budget/budget.dart';
import '../views/budget/budgetreport.dart';
import '../views/not_found.dart';
import '../views/authentication/signin.dart';
import 'package:anjuman_e_najmi/routes/routes_names.dart';
import '../views/profile/delete.dart';
import '../views/profile/edit_profile.dart';
import '../views/profile/profile.dart';
import '../views/authentication/signup.dart';
import '../views/receipt/viewreceipt.dart';
import '../views/report/report.dart';

class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings setting) {
    Home bottomBarArgs = Home(selectedIndex: 0);
    Budget budgetTabArgs = Budget(selectedIndex: 0);
    switch (setting.name) {
      case signIn:
        return MaterialPageRoute(builder: (_) => SignIn());
      case signUp:
        return MaterialPageRoute(builder: (_) => SignUp());
      case botttomnav:
        return MaterialPageRoute(
            builder: (_) => Home(selectedIndex: bottomBarArgs.selectedIndex));
      case addReceipt:
        return MaterialPageRoute(builder: (_) => AddReceipt());

      case viewReceipt:
        return MaterialPageRoute(builder: (_) => ViewReceipt());
      case profile:
        return MaterialPageRoute(builder: (_) => Profile());
      case editprofile:
        return MaterialPageRoute(builder: (_) => EditProfile());
      case delete:
        return MaterialPageRoute(builder: (_) => Delete());
      case assignUser:
        return MaterialPageRoute(builder: (_) => UserRole());
      case rolesManagement:
        return MaterialPageRoute(builder: (_) => RolesManagement());
      case report:
        return MaterialPageRoute(builder: (_) => Report());
      case budgetreport:
        return MaterialPageRoute(builder: (_) => BudgetReport());
      case addUser:
        return MaterialPageRoute(builder: (_) => AddUser());
      case budget:
        return MaterialPageRoute(
            builder: (_) => Budget(selectedIndex: budgetTabArgs.selectedIndex));
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case roles:
        return MaterialPageRoute(builder: (_) => Roles());
    }
    return MaterialPageRoute(builder: (_) => const NotFoundPage());
  }
}
