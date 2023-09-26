import 'dart:developer';
import 'package:anjuman_e_najmi/data/model/adduser_role.dart';
import 'package:anjuman_e_najmi/data/model/userrole_model.dart';
import 'package:anjuman_e_najmi/logic/cubit/role/role_state.dart';
import 'package:anjuman_e_najmi/utils/global_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/model/userrole_resposne.dart';
import '../../../data/repository/role_repository.dart';

class RoleCubit extends Cubit<RoleState> {
  RoleCubit()
      : super(RoleState(
            roles: [], roleId: 0, permission: {}, selectedDropdownValues: []));

  final roleRepository = RoleRepository();

  // getRoles() {
  //   print("get roles function called");

  //   var roley = roleRepository.getRoles();

  //   emit(state.copyWith(roles_: roley));
  // }

  addRole(String m) {
    emit(state.copyWith(rroleName: m));
  }

  adduserRole(String m) {
    emit(state.copyWith(aadduserrole: m));
  }

  editrole(String r) {
    emit(state.copyWith(eeditroleName: r));
    debugPrint("edit Role: ${state.editrole}");
  }

  addrole(String r) {
    emit(state.copyWith(rroleName: r));
    debugPrint("Add Role: ${state.roleName}");
  }

  initializeDropDown() {
    var a = List.generate(
      state.rolepermissionList?.length ?? 0,
      (index) => "n",
    );
    emit(state.copyWith(selectedDropdownValues: a));
    print("Initial " + state.selectedDropdownValues.toString());
  }

  int index = 0;
  initializeEditDropDown() {
    debugPrint(
        "edit Role: ${state.rolepermissionList?.length} ${state.response?.data?.permissions?[index].permission.toString()}");
    List<String>? a = List.generate(
      state.rolepermissionList?.length ?? 0,
      (index) {
        if (state.response?.data?.permissions?[index].permission != null &&
            state.response?.data != null) {
          print(
              "GEt Role ${state.response?.data?.permissions?[index].permission.toString()}");
          return state.response?.data?.permissions?[index].permission ?? "n";
        } else {
          return "n";
        }
      },
    );
    emit(state.copyWith(selectedDropdownValues: a));
    print("Waqsa" + state.permission.toString());
  }

  updateDropdown(int index, String newVal) {
    state.selectedDropdownValues![index] = newVal;
    emit(state.copyWith(selectedDropdownValues: state.selectedDropdownValues));
  }

  String userRoleId = '';
  int get getuserRoleID => state.roleId == null ? 000 : state.roleId!;

  saveDataInRoleShared() async {
    debugPrint(userRoleId);
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('id', userRoleId);
    pre.setString('name', state.roleName ?? "");
    pre.setString('description', state.description ?? "");
    pre.setString('created_at', state.createdAt ?? "");
    pre.setString('updated_at', state.updatedAt ?? "");
    getRoleSharedData();
  }

  static int? roleid;

  getRoleSharedData() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    debugPrint("${pre.getString('id')} called ${state.roleId}");
    debugPrint(pre.getString('id'));
    var uroleid = pre.getString('id');
    if (uroleid != null) {
      var rolename = pre.getString('name');
      debugPrint("userRoleid $uroleid tt $getuserRoleID");
      var description = pre.getString('description');
      var createdAt = pre.getString('created_at');
      var updatedAt = pre.getString('updated_at');

      emit(state.copyWith(
          rroleId: int.tryParse(userRoleId),
          rroleName: rolename,
          ddescription: description,
          ccreatedAt: createdAt,
          uupdatedAt: updatedAt));
      debugPrint("userRoleid ${state.roleId} $userRoleId");
      debugPrint("rolename ${rolename.toString()}");
    }
  }

  List<UserRoleModel> userRoleList = [];
  getUserRole(context) async {
    final roleCub = BlocProvider.of<RoleCubit>(context, listen: false);
    await roleRepository.getUserRole().then((value) {
      final response = UserRoleRespsone.fromJson(value);
      if (response.userRoleModel != null) {
        int i = 0;
        if (response.statusCode != null && response.statusCode == 200) {
          userRoleList.clear();
          userRoleList.addAll(response.userRoleModel!);
          Future.delayed(
              const Duration(milliseconds: 300), () => saveDataInRoleShared());
          log("Result getUser: ${userRoleList.length.toString()} ${response.userRoleModel![i].id.toString()}");
          emit(state.copyWith(
              uuserRole: userRoleList, rroleId: response.userRoleModel?[i].id));
          roleid = roleCub.getuserRoleID;
        }
      }
    });
  }

  List<UserRoleModel> rolepermissionList = [];
  permission(String add) async {
    await roleRepository.permissons().then((value) {
      final response = UserRoleRespsone.fromJson(value);
      if (response.userRoleModel != null) {
        int i = 0;
        if (response.statusCode != null && response.statusCode == 200) {
          rolepermissionList.clear();

          rolepermissionList.addAll(response.userRoleModel!);
          Future.delayed(
              const Duration(seconds: 0), () => saveDataInRoleShared());
          log("Result Permission: ${userRoleList.length.toString()} ${response.userRoleModel![i].id.toString()}");
          emit(state.copyWith(
              rrolepermissionList: rolepermissionList,
              rroleId: response.userRoleModel![i].id));
          add == "Add Role" ? initializeDropDown() : initializeEditDropDown();
        }
      }
    });
  }

  editUserRole(context, id) async {
    Map<String, dynamic> variable = {
      "name": state.editroleName,
      "permission": state.permission
    };

    await roleRepository.editUserRole(variable, id).then((value) {
      log("EditUserRole: ${state.editroleName} ");
      final response = AddUserRoleModel.fromJson(value);
      log("Result editUserRole: $response ");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          id != 0) {
        emit(state.copyWith(
            eeditroleName: response.data?.name,
            ppermission: state.permission,
            ppermissionlist: response.data?.permissions));
      }
    });
    await getUserRole(context);
    Globals.showToast("UserRole is Edit");
    Navigator.pop(context);
  }

  void editTempRole(String code, String access, List<String>? mylist) {
    // Create a copy of the existing permissions map
    int i = 0;
    final Map<String, String> updatedPermissions =
        Map.from(state.permission ?? {});

    // Update or add the new permission
    if (access != '') updatedPermissions[code] = access;

    // Initialize permissions for codes that don't have an entry with "n"
    for (final rolePermission in state.response?.data?.permissions ?? []) {
      final roleCode = rolePermission.code;
      if (!updatedPermissions.containsKey(roleCode)) {
        updatedPermissions[roleCode] = mylist![i] ?? "";
      }
      i++;
    }

    // Update the state with the modified permissions map
    emit(state.copyWith(ppermission: updatedPermissions));

    // Debug print the updated permissions
    debugPrint("Edit On cHnagev " + updatedPermissions.toString());
  }

  void addTempRole(String code, String access) {
    // Create a copy of the existing permissions map
    final Map<String, String> updatedPermissions =
        Map.from(state.permission ?? {});

    // Update or add the new permission
    updatedPermissions[code] = access;

    // Initialize permissions for codes that don't have an entry with "n"
    for (final rolePermission in state.rolepermissionList ?? []) {
      final roleCode = rolePermission.code;
      if (!updatedPermissions.containsKey(roleCode)) {
        updatedPermissions[roleCode] = "n";
      }
    }

    // Update the state with the modified permissions map
    emit(state.copyWith(ppermission: updatedPermissions));

    // Debug print the updated permissions
    debugPrint(updatedPermissions.toString());
  }

  addUserRole(context) async {
    Map<String, dynamic> variable = {
      "name": state.roleName,
      "permission": state.permission
      //  "permission": {"app.dashboard": "w"}
    };

    await roleRepository.addUserRole(variable).then((value) {
      final response = AddUserRoleModel.fromJson(value);
      log("Result   addUserRole: $response");
      if (response.statusCode != null && response.statusCode == 200) {
        emit(state.copyWith(
            rroleName: response.data?.id.toString(),
            ppermission: state.permission,
            ppermissionlist: response.data?.permissions));
      }
    });
    await getUserRole(context);
    Globals.showToast("Role is Added");
    Navigator.pop(context);
  }

  deleteUserRole(context, int id) async {
    await roleRepository.deleteUserRole(id).then((value) {
      final response = UserRoleRespsone.fromJson(value);
      log("Result  deleteUserRole: $response");
      log("RoleCubit: $roleid");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          id != 0) {
        debugPrint("Delete USer ROle ${response.statusCode.toString()}");

        Globals.showToast("User Role is Deleted");
      }
    });
  }

  List<Data>? getuserrolelist = [];
  getUserRoleId(context, id) async {
    await roleRepository.getuserRolesId(id).then((value) {
      final response = AddUserRoleModel.fromJson(value);
      if (response.data != null && id != null && id != 0) {
        if (response.statusCode != null && response.statusCode == 200) {
          getuserrolelist?.add(response.data!);
          // response["items"][0]["volumeInfo"]["title"]
//response["items"][0]["volumeinfo"]["authors"][0]
          debugPrint(
              "roleID Permisiion: ${response.data!.permissions?[1].permission}  ${state.response?.data?.permissions?[1].id}");
          emit(state.copyWith(rresponse: response));
        }
      }
    });
  }
}
