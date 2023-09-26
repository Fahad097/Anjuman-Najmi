import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:anjuman_e_najmi/data/model/user_model.dart';
import 'package:anjuman_e_najmi/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
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
        ));

  final authRepository = AuthRepository();

  String userId = '';
  String deviceId = '';
  int get getuserID => state.userId == null ? 000 : state.userId!;
  String get getUserName => state.username == "" ? '' : state.username ?? "";
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
    pre.setString('password', state.password ?? "");
    pre.setString('token', state.token ?? "");

    pre.setString('role_name', state.roleName ?? "");
    pre.setString('fullname', state.fullname ?? "");
    await getSharedData();
  }

  getSharedData() async {
    debugPrint("called");
    SharedPreferences pre = await SharedPreferences.getInstance();
    debugPrint(pre.getString('id'));
    var us = pre.getString('id');
    if (us != null) {
      var username = pre.getString('username');

      var fullname = pre.getString('fullname');
      var email = pre.getString(
        'email',
      );
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
    bool? isValid = state.loginkey?.currentState?.validate();
    if (isValid == false) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: Globals.kUniversalColor)));
    Map<String, dynamic> variable = {
      'username': state.username,
      'password': state.password,
      'device_id': null
    };
    debugPrint("SSS $userId");
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
              iisloading: false));
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
          emit(state.copywith(eerror: "Invalid Username or Password"));
        }
      }
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
          id != 0 &&
          user != null) {
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

  getAllUser(context) async {
    await authRepository.getAllUser().then((value) {
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
    user = getuserID;
    Map<String, dynamic> variable = {
      "fullname": state.fullname,
      "email": state.email,
      "role_id": state.roleId,
      "is_pending": state.isPending,
      "username": state.username,
      "password": state.password
    };
    emit(state.copywith(iisloading: true));
    showDialog(
        context: context,
        barrierDismissible: state.isloading ?? false,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: Globals.kUniversal)));

    await authRepository.editProfile(variable, id).then((value) {
      final response = LoginResponse.fromJson(value);
      log("Result editProfilet: $response");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          user != 0 &&
          user != null) {
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
    Map<String, dynamic> variable = {
      "fullname": state.updatefullname,
      "email": state.updatemail,
      "role_id": state.updateroleId,
      "is_pending": 0,
      "username": state.updateusername,
      "password": state.updatepassword
    };

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
        ));
      }
      Navigator.pop(context);
    });
  }

  userFlag(int id, int isPending) async {
    Map<String, dynamic> variable = {
      "fullname": state.updatefullname,
      "email": state.updatemail,
      "role_id": state.updateroleId,
      "is_pending": isPending == 0 ? 1 : 0,
      "username": state.updateusername,
      "password": state.updatepassword
    };
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
            uupdateisPending: response.userModel?.isPending));
      }
      Globals.showToast("User Profile is Edit");
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
    showDialog(
        context: context,
        barrierDismissible: state.isloading ?? false,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: Globals.kUniversal)));
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
    showDialog(
        context: context,
        barrierDismissible: state.isloading ?? false,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: Globals.kUniversal)));
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
        Globals.showToast("Signup SuccessFully");
        Future.delayed(const Duration(seconds: 1), () => saveDataInShared());
        Navigator.pushNamedAndRemoveUntil(
            context, botttomnav, (route) => false);
      }
    });
  }

  Future<LoginResponse> createAlbum(String name, String password) async {
    final http.Response response = await http.post(
      Uri.parse('http://34.239.93.196/api/login'),
      body: jsonEncode(<String, String>{
        'username': name,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      log("Result: ${json.decode(response.body)}");

      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      log("Result: ${json.decode(response.body)}");
      throw Exception('Failed to create album.');
    }
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
