import 'package:anjuman_e_najmi/data/model/adduser_role.dart';
import 'package:anjuman_e_najmi/data/model/userrole_model.dart';
import '../../../data/model/role_model.dart';

class RoleState {
  List<RoleModel>? roles;
  bool? isLoading;
  final int? roleId;
  String? roleName;
  String? editroleName;
  String? description;
  String? createdAt;
  String? dropdownvalue;
  String? updatedAt;
  AddUserRoleModel? response;
  List<UserRoleModel>? userRole;
  List<UserRoleModel>? rolepermissionList;
  List<Data>? getuserrolelist;
  List<String>? selectedDropdownValues;

  Map<String, String>? permission;
  List<dynamic>? permissionlist;
  int? editrole;
  String? adduserrole;

  RoleState(
      {this.roles,
      this.isLoading,
      this.editroleName,
      this.editrole,
      this.dropdownvalue,
      this.roleId,
      this.rolepermissionList,
      this.roleName,
      this.response,
      this.getuserrolelist,
      this.permissionlist,
      this.adduserrole,
      this.permission,
      this.userRole,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.selectedDropdownValues});

  RoleState copyWith(
      {List<RoleModel>? roles_,
      bool? isLoading_,
      final int? rroleId,
      String? ddropdownvalue,
      int? eeditrole,
      List<Data>? ggetuserrolelist,
      AddUserRoleModel? rresponse,
      List<UserRoleModel>? uuserRole,
      String? ddescription,
      List<UserRoleModel>? rrolepermissionList,
      Map<String, String>? ppermission,
      String? ccreatedAt,
      String? eeditroleName,
      List<dynamic>? ppermissionlist,
      String? aadduserrole,
      String? uupdatedAt,
      String? rroleName,
      List<String>? selectedDropdownValues}) {
    return RoleState(
        roles: roles_ ?? roles,
        description: ddescription ?? description,
        response: rresponse ?? response,
        isLoading: isLoading_ ?? isLoading,
        editroleName: eeditroleName ?? editroleName,
        rolepermissionList: rrolepermissionList ?? rolepermissionList,
        adduserrole: aadduserrole ?? adduserrole,
        editrole: eeditrole ?? editrole,
        getuserrolelist: ggetuserrolelist ?? getuserrolelist,
        dropdownvalue: ddropdownvalue ?? dropdownvalue,
        roleId: rroleId ?? roleId,
        permission: ppermission ?? permission,
        permissionlist: ppermissionlist ?? permissionlist,
        roleName: rroleName ?? roleName,
        userRole: uuserRole ?? userRole,
        createdAt: ccreatedAt ?? createdAt,
        updatedAt: uupdatedAt ?? updatedAt,
        selectedDropdownValues:
            selectedDropdownValues ?? this.selectedDropdownValues);
  }
}
