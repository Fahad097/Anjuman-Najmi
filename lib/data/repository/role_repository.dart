import 'package:anjuman_e_najmi/data/provider/role_provider.dart';
import 'package:flutter/material.dart';
import '../model/role_model.dart';

class RoleRepository {
  final roleProvider = RoleProvider();
  Future getuserRoles() async {
    final result = await roleProvider.getUserRole();
    debugPrint("getuserRole Repository ${result.toString()}");
    return result;
  }

  Future permissons() async {
    final result = await roleProvider.permission();
    debugPrint("Permssion Repository ${result.toString()}");
    return result;
  }

  Future getuserRolesId(int id) async {
    final result = await roleProvider.getUserRoleId(id);
    debugPrint("getuserRoleID Repository ${result.toString()}");
    return result;
  }

  Future getUserRole() async {
    final result = await roleProvider.getUserRole();
    debugPrint("getUserRole Repository ${result.toString()}");
    return result;
  }

  Future editUserRole(Map<String, dynamic> variable, int id) async {
    final result = await roleProvider.editUserRole(variable, id);
    debugPrint("editUserROle Repository ${result.toString()}");
    return result;
  }

  Future addUserRole(Map<String, dynamic> variable) async {
    final result = await roleProvider.addUserRole(variable);
    debugPrint("editProfile Repository ${result.toString()}");
    return result;
  }

  Future deleteUserRole(int id) async {
    final result = await roleProvider.deleteUserRole(id);
    debugPrint("deleteaccount Repository ${result.toString()}");
    return result;
  }

  List<RoleModel> getRoles() {
    return roleProvider.getRoles();
  }
}
