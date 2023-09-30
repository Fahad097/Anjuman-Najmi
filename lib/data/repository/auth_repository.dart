import 'package:flutter/cupertino.dart';
import '../provider/auth_provider.dart';
import '../model/access_model.dart';
import '../model/user_model.dart';

final provider = AuthProvider();

class AuthRepository {
  Future signup(Map<String, dynamic> variable) async {
    final result = await provider.signup(variable);
    debugPrint(result.toString());
    return result;
  }

  Future addUser(Map<String, dynamic> variable) async {
    final result = await provider.addUser(variable);
    debugPrint(result.toString());
    return result;
  }

  Future signin(Map<String, dynamic> variable) async {
    final result = await provider.signin(variable);
    debugPrint("Singin ${result.toString()}");
    return result;
  }

  Future deleteAccount(int id) async {
    final result = await provider.deleteAccount(id);
    debugPrint("deleteaccount Repository ${result.toString()}");
    return result;
  }

  Future getProfile(int id) async {
    final result = await provider.getProfile(id);
    debugPrint("getProfile Repository ${result.toString()}");
    return result;
  }

  Future getAllUser() async {
    final result = await provider.getAllUser();
    debugPrint("getAllUser Repository ${result.toString()}");
    return result;
  }

  Future editProfile(Map<String, dynamic> variable, int id) {
    final result = provider.editProfile(variable, id);
    debugPrint("editProfile Repository ${result.toString()}");
    return result;
  }

  Future<UserModel> loginUser() async {
    return provider.loginUser();
  }

  List<AccessModel>? getRoleAccesses(int roleId) {
    return provider.getRoleAccesses(roleId);
  }
}
