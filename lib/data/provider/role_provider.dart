import 'package:anjuman_e_najmi/data/model/role_model.dart';
import 'package:flutter/cupertino.dart';
import '../../network/api_urls.dart';
import '../../network/service_helper.dart';

class RoleProvider {
  Future deleteUserRole(int id) async {
    debugPrint(ApiUrls.deleteuserrole + id.toString());
    return await ServiceHelper.deleteApiCall(
        ApiUrls.deleteuserrole + id.toString());
  }

  Future getUserRoleId(int id) async {
    debugPrint(ApiUrls.getuserRoleId + id.toString());
    return await ServiceHelper.getApiCall(
        ApiUrls.getuserRoleId + id.toString());
  }

  Future getUserRole() async {
    debugPrint(ApiUrls.getuserole);
    return await ServiceHelper.getApiCall(ApiUrls.getuserole);
  }

  Future permission() async {
    debugPrint(ApiUrls.permissions);
    return await ServiceHelper.getApiCall(ApiUrls.permissions);
  }

  Future editUserRole(Map<String, dynamic> variable, int id) async {
    debugPrint(ApiUrls.edituserrole + id.toString());
    return await ServiceHelper.putApiCall(
        ApiUrls.edituserrole + id.toString(), variable);
  }

  Future addUserRole(Map<String, dynamic> variable) async {
    debugPrint(ApiUrls.adduserRole);
    return await ServiceHelper.postApiCall(ApiUrls.adduserRole, variable);
  }

  List<RoleModel> getRoles() {
    List response = [
      {"id": 1, "name": "Admin"},
      {"id": 2, "name": "User"},
      {"id": 3, "name": "Cashier"},
      {"id": 4, "name": "Supplier"},
      {"id": 5, "name": "Purchaser"},
      {"id": 6, "name": "Treasurer"},
      {"id": 7, "name": "Owner"},
    ];

    List<RoleModel> roles = [];

    if (response.length > 0) {
      for (int i = 0; i < response.length; i++) {
        final roleModel = RoleModel.fromJson(response[i]);
        roles.add(roleModel);
      }
    }

    return roles;
  }
}
