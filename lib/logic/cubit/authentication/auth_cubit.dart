import 'dart:async';
import 'dart:developer';
import 'package:anjuman_e_najmi/data/model/permission.dart';
import 'package:anjuman_e_najmi/data/model/user_model.dart';
import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/model/getuser_response.dart';
import '../../../data/model/login_response.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/model/access_model.dart';
import '../../../utils/global_constants.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthState(
            username: "",
            email: "",
            phoneNum: "",
            timerstart: 59,
            activeConnection: false,
            isloading: false,
            isPending: 0,
            userList: [],
            editprofileState: 'searching',
            profileState: 'searching',
            getprofileState: 'searching'));

  final authRepository = AuthRepository();

  String userId = '';
  String userPassword = '';
  String deviceId = '';
  int get getuserID => state.userId == null ? 000 : state.userId!;
  String get getUserName => state.username == "" ? '' : state.username ?? "";
  String get getUserPassword =>
      state.password == "" ? '' : state.password ?? "";
  String get getUserFullName =>
      state.fullname == "" ? '' : state.fullname ?? "";
  String get getToken => state.token == "" ? '' : state.token ?? "";
  bool get userIDCanBeNull => state.userId == null ? true : false;

  int index = 0;
  username(String m) {
    emit(state.copywith(uusername: m));
  }

  fullName(String fname) {
    emit(state.copywith(ffullname: fname));
  }

  email(String e) {
    emit(state.copywith(eemail: e));
  }

  isPending(int e) {
    emit(state.copywith(iisPending: e));
  }

  phone(String m) {
    emit(state.copywith(phoneNum: m));
  }

  password(String m) {
    emit(state.copywith(ppassword: m));
  }

  ///Add or Edit User function
  updateroleId(int n) {
    emit(state.copywith(uupdateroleId: n));
  }

  updateusername(String m) {
    emit(state.copywith(uupdateusername: m));
  }

  updatefullName(String fname) {
    emit(state.copywith(uupdatefullname: fname));
  }

  updateemail(String e) {
    emit(state.copywith(uupdatemail: e));
  }

  updatepassword(String m) {
    emit(state.copywith(uupdatepassword: m));
  }

  updateIsPending(int m) {
    emit(state.copywith(uupdateisPending: m));
  }

  saveDataInShared() async {
    debugPrint("ttttt ${state.token} $userId");
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('id', userId);
    pre.setString('username', state.username ?? "");
    pre.setString('email', state.email ?? "");
    pre.setString('password', userPassword);
    pre.setString('token', state.token ?? "");

    pre.setString('role_name', state.roleName ?? "");
    pre.setString('fullname', state.fullname ?? "");
    await getSharedData();
  }

  getSharedData() async {
    debugPrint("called");
    SharedPreferences pre = await SharedPreferences.getInstance();
    debugPrint(pre.getString('id'));
    debugPrint(pre.getString('password'));
    var us = pre.getString('id');
    if (us != null) {
      var username = pre.getString('username');

      var fullname = pre.getString('fullname');
      var email = pre.getString(
        'email',
      );
      pre.getString('password');
      var phone = pre.getString('phone_no');
      var password = pre.getString('password');
      var token = pre.getString('token');
      var rolename = pre.getString('role_name');
      debugPrint("RRR $token");
      emit(state.copywith(
          uuserid: int.parse(userId),
          uusername: username,
          eemail: email,
          phoneNu: phone,
          ttoken: token,
          rroleName: rolename,
          ffullname: fullname,
          ppassword: password));
    }
    debugPrint("user id $userId");
  }

  final GlobalKey<FormState> formkeylogin = GlobalKey<FormState>();

  signin(context) {
    Map<String, dynamic> variable = {
      'username': state.username,
      'password': state.password,
      'device_id': null
    };
    debugPrint("SSS $userId");
    emit(state.copywith(iisloading: true));
    authRepository.signin(variable).then((result) async {
      final response = LoginResponse.fromJson(result);
      userId = response.userModel!.id.toString();
      log("Result Cubit: $result");
      if (response.statusCode != null && response.statusCode == 200) {
        if (response.userModel!.id != 0) {
          // user is varified profile

          emit(state.copywith(
              uusername: response.userModel?.username,
              ppassword: response.userModel?.password,
              ttoken: response.userModel?.token,
              ppermission: response.userModel?.permissions,
              iisloading: false));
          permissionService
              .updateUserPermissions(response.userModel?.permissions);
          debugPrint(
              "debug ${response.userModel!.id.toString()} ${state.token.toString()}");
          // Future.delayed(const Duration(seconds: 1), () => saveDataInShared());
          await saveDataInShared();
          await Globals.mainInit();
          Globals.showToast("Login Successfully");
          Navigator.pushNamedAndRemoveUntil(
              context, botttomnav, (route) => false);
          //   Navigator.pushNamedAndRemoveUntil(context, splash, (route) => false);
        } else {
          emit(state.copywith(
              eerror: "Invalid Username or Password", iisloading: false));
          Globals.showToast("Invalid Username or Password");
        }
      } else {
        print('error');
      }
    }).onError((error, stackTrace) {
      emit(state.copywith(
          eerror: "Invalid Username or Password", iisloading: false));
      Globals.showToast("Invalid Username or Password");
    });
  }

  static int? user;
  deleteAccount(context, int id) async {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    user = authCub.getuserID;
    await authRepository.deleteAccount(id).then((value) {
      final response = LoginResponse.fromJson(value);

      log("Result  deleteAccount: $response");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          id != 0) {
        debugPrint("${response.userModel?.fullname} $id");
        Globals.showToast("Your Account is Deleted");
        Navigator.pushNamedAndRemoveUntil(context, splash, (route) => false);
      }
    });
  }

  deleteUserAccount(context, int id) async {
    emit(state.copywith(iisloading: true));
    showDialog(
        context: context,
        barrierDismissible: state.isloading ?? false,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: Globals.kUniversal)));
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    user = authCub.getuserID;
    await authRepository.deleteAccount(id).then((value) {
      final response = LoginResponse.fromJson(value);

      log("Result  deleteAccount: $response");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          id != 0) {
        debugPrint("${response.userModel?.fullname} $id");
        Globals.showToast("User Account is Deleted");
        emit(state.copywith(iisloading: false));
        Navigator.pop(context);
        Navigator.pop(context);

        getAllUser(context);
      }
    });
  }

  getProfile(context, int id) async {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    user = authCub.getuserID;
    await authRepository.getProfile(id).then((value) {
      final response = LoginResponse.fromJson(value);
      log("Result getProfilet: $response");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          id != 0) {
        emit(state.copywith(
            eemail: response.userModel?.email,
            rroleName: response.userModel?.roleName,
            rroleId: response.userModel?.roleId,
            iisPending: response.userModel?.isPending,
            ffullname: response.userModel?.fullname));
      }
    });
  }

  getUser(context, int id) async {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    user = authCub.getuserID;
    await authRepository.getProfile(id).then((value) {
      final response = LoginResponse.fromJson(value);
      log("Result getProfilet: $response");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          id != 0) {
        emit(state.copywith(
            eemail: response.userModel?.email,
            rroleName: response.userModel?.roleName,
            rroleId: response.userModel?.roleId,
            iisPending: response.userModel?.isPending,
            ffullname: response.userModel?.fullname));
      }
    });
  }

  List<UserModel> userList = [];

  getAllUser(context) {
    authRepository.getAllUser().then((value) {
      final response = GetUserResponse.fromJson(value);

      if (response.userModel != null) {
        if (response.statusCode != null && response.statusCode == 200) {
          userList.clear();
          userList.addAll(response.userModel!);
          log("Result getUser: ${userList.length.toString()}");
          emit(state.copywith(uuserList: userList));
        }
      }
    });
  }

  editProfile(context, int id) async {
    Map<String, dynamic> variable;
    print(state.password);

    if (state.password == '') {
      variable = {
        "fullname": state.fullname,
        "email": state.email,
        "role_id": state.roleId,
        "is_pending": state.isPending,
        "username": state.username,
      };
    } else {
      variable = {
        "fullname": state.fullname,
        "email": state.email,
        "role_id": state.roleId,
        "is_pending": state.isPending,
        "username": state.username,
        "password": state.password
      };
    }

    emit(state.copywith(iisloading: true));

    await authRepository.editProfile(variable, id).then((value) {
      final response = LoginResponse.fromJson(value);
      log("Result editProfilet: $response");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          id != 0) {
        emit(state.copywith(
            ffullname: response.userModel?.fullname,
            eemail: response.userModel?.email,
            uusername: response.userModel?.username,
            ppassword: response.userModel?.password,
            rroleId: response.userModel?.roleId,
            iisloading: false,
            iisPending: response.userModel?.isPending));
      }
      Globals.showToast("Profile is Edit");
      Navigator.pop(context);
    });
  }

  editUserProfile(context, int id) async {
    Map<String, dynamic> variable;
    print(state.updatepassword);
    if (state.updatepassword == '') {
      variable = {
        "fullname": state.updatefullname,
        "email": state.updatemail,
        "role_id": state.updateroleId,
        "is_pending": 0,
        "username": state.updateusername,
      };
    } else {
      variable = {
        "fullname": state.updatefullname,
        "email": state.updatemail,
        "role_id": state.updateroleId,
        "is_pending": 0,
        "username": state.updateusername,
        "password": state.updatepassword
      };
    }

    emit(state.copywith(iisloading: true));
    await authRepository.editProfile(variable, id).then((value) {
      final response = LoginResponse.fromJson(value);
      log("Result UsereditProfile: $response");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          id != 0) {
        emit(state.copywith(
            uupdatefullname: response.userModel?.fullname,
            uupdatemail: response.userModel?.email,
            uupdateusername: response.userModel?.username,
            uupdatepassword: response.userModel?.password,
            uupdateroleId: response.userModel?.roleId,
            iisloading: false));
      }
      Globals.showToast("User Profile is Edit");
      Navigator.pop(context);
    });
  }

  userFlag(List<UserModel>? userList, index, context) {
    Map<String, dynamic> variable = {
      "fullname": userList?[index].fullname,
      "email": userList?[index].email,
      "role_id": userList?[index].roleId,
      "is_pending": (userList?[index].isPending == 0) ? 1 : 0,
      "username": userList?[index].username
    };
    print(
        "${userList?[index].id} ${isPending} ${state.updatefullname} ${state.updatemail} ${state.updateroleId} ${state.updateusername}");
    authRepository
        .editProfile(variable, userList?[index].id ?? 0)
        .then((value) {
      final response = LoginResponse.fromJson(value);
      log("Result UsereditProfile: $response");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          userList?[index].id != 0) {
        emit(state.copywith(
            uupdatefullname: response.userModel?.fullname,
            uupdatemail: response.userModel?.email,
            uupdateusername: response.userModel?.username,
            uupdatepassword: response.userModel?.password,
            uupdateroleId: response.userModel?.roleId,
            uupdateisPending: response.userModel?.isPending));
      }
      getAllUser(context);
    });
  }

  addUser(context) async {
    var variable = {
      "fullname": state.updatefullname,
      "email": state.updatemail,
      "role_id": state.updateroleId,
      "is_pending": 0,
      "username": state.updateusername,
      "password": state.updatepassword
    };
    emit(state.copywith(iisloading: true));
    await authRepository.addUser(variable).then((result) {
      final response = LoginResponse.fromJson(result);
      if (response.statusCode != null && response.statusCode == 200) {
        userId = response.userModel!.id.toString();
        log("Result: $userId");
        emit(state.copywith(
            uupdateusername: response.userModel!.username,
            uupdatepassword: response.userModel!.password,
            uupdatemail: response.userModel!.email,
            uupdatefullname: response.userModel!.fullname,
            iisloading: false));
        Globals.showToast("New User is Added");
        Navigator.pop(context);
      }
    });
  }

  signup(BuildContext context) async {
    var variable = {
      "fullname": state.fullname,
      'username': state.username,
      'password': state.password,
      'email': state.email,
    };
    emit(state.copywith(iisloading: true));

    await authRepository.signup(variable).then((result) {
      final response = LoginResponse.fromJson(result);
      if (response.statusCode != null && response.statusCode == 200) {
        userId = response.userModel!.id.toString();
        log("Result: $userId");
        emit(state.copywith(
            uusername: response.userModel!.username,
            ppassword: response.userModel!.password,
            eemail: response.userModel!.email,
            ffullname: state.fullname,
            iisloading: false));
        Globals.showToast(response.userModel?.success);
        Future.delayed(const Duration(seconds: 1), () => saveDataInShared());
      }
    }).onError((error, stackTrace) {
      emit(state.copywith(eerror: "There is some issue", iisloading: false));
      Globals.showToast("There is some issue");
    });
  }

  void flogOut(context) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.clear();
    //  await clearData();
    // clearText();
    final authBloc = BlocProvider.of<AuthCubit>(context);
    authBloc.resetAuth();
    await Navigator.pushNamedAndRemoveUntil(context, signIn, (route) => false);
  }

  void check(XFile xFile) {
    emit(state.copywith(
      iimagefile: xFile,
    ));
  }

  void image(XFile xFile) {
    emit(state.copywith(
      iimagefile: xFile,
    ));
  }

  getRoleAccess(int roleId) {
    emit(state.copywith(iisloading: true));
    final accesses = authRepository.getRoleAccesses(roleId);
    emit(state.copywith(accesses_: accesses, iisloading: false));
  }

  resetAuth() {
    userList.clear();
    emit(AuthState(
        username: "",
        email: "",
        phoneNum: "",
        isloading: false,
        password: "",
        userId: 0,
        isPending: 0,
        roleId: 0));
  }
}
