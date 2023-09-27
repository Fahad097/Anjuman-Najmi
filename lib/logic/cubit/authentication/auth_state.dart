part of 'auth_cubit.dart';

class AuthState {
  final String? roleName;
  final String? email;
  final String? password;
  final int? roleId;
  final String? username;
  int? isPending;
  final String? phoneNum;
  final String? token;
  final List<UserModel>? userList;
  final int? userId;
  bool? isloading;
  Timer? timer;
  int? timerstart;
  final bool? activeConnection;
  GlobalKey<FormState>? loginkey;
  final imagefile;
  final Map<String,dynamic>? permission;
  final String? fullname;
  final String? error;
  List<AccessModel>? accesses;

  final String? updateusername;
  final String? updatefullname;
  final String? updatepassword;
  final String? updatemail;
  final int? updateroleId;
  final int? updateisPending;

  AuthState(
      {this.phoneNum,
      this.updateisPending,
      this.permission,
      this.userList,
      this.token,
      this.roleName,
      this.roleId,
      this.fullname,
      this.timerstart,
      this.error,
      this.isloading,
      this.timer,
      this.loginkey,
      this.activeConnection,
      this.imagefile,
      this.password,
      this.isPending,
      this.email,
      this.username,
      this.userId,
      this.accesses,
      this.updateusername,
      this.updatefullname,
      this.updatepassword,
      this.updateroleId,
      this.updatemail});

  AuthState copywith({
    final int? uupdateisPending,
    final String? uusername,
    final String? ffullname,
    final String? ppassword,
    final String? rroleName,
    final int? rroleId,
    final int? iisPending,
    final String? phoneNu,
    final String? ttoken,
    final Map<String,dynamic>? ppermission,
    final List<UserModel>? uuserList,
    bool? iisloading,
    final String? eemail,
    final String? eerror,
    final int? uuserid,
    final iimagefile,
    GlobalKey<FormState>? lloginkeyy,
    String? phoneNum,
    List<AccessModel>? accesses_,
    final String? uupdateusername,
    final String? uupdatefullname,
    final String? uupdatepassword,
    final String? uupdatemail,
    final int? uupdateroleId,
  }) {
    return AuthState(
      phoneNum: phoneNu ?? phoneNum,
      updateisPending: uupdateisPending ?? updateisPending,
      roleName: rroleName ?? roleName,
      roleId: rroleId ?? roleId,
      isPending: iisPending ?? isPending,
      error: eerror ?? error,
      token: ttoken ?? token,
      permission: ppermission ?? permission,
      password: ppassword ?? password,
      email: eemail ?? email,
      userList: uuserList ?? userList,
      isloading: iisloading ?? isloading,
      username: uusername ?? username,
      fullname: ffullname ?? fullname,
      loginkey: lloginkeyy ?? loginkey,
      userId: uuserid ?? userId,
      imagefile: iimagefile ?? imagefile,
      accesses: accesses_ ?? accesses,
      updateusername: uupdateusername ?? updateusername,
      updatefullname: uupdatefullname ?? updatefullname,
      updatepassword: uupdatepassword ?? updatepassword,
      updatemail: uupdatemail ?? updatemail,
      updateroleId: uupdateroleId ?? updateroleId,
    );
  }
}
