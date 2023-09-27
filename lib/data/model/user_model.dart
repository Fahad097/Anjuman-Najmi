import 'package:anjuman_e_najmi/data/model/permission.dart';

class UserModel {
  int? id;
  String? fullname;
  String? email;
  String? password;
  String? username;
  int? roleId;
  String? createdAt;
  int? isPending;
  int? isDeleted;
  String? roleName;
  String? success;
  Map<String,dynamic>? permissions;
  String? token;

  UserModel(
      {this.id,
      this.fullname,
      this.email,
      this.password,
      this.username,
      this.roleId,
      this.createdAt,
      this.isPending,
      this.isDeleted,
      this.roleName,
      this.success,
      this.permissions,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
    roleId = json['role_id'];
    isPending = json['is_pending'];
    isDeleted = json['is_deleted'];
    roleName = json['role_name'];
    createdAt = json['created_at'];
    success = json['success'];
    permissions = json['permissions'] != null
        ? json['permissions']!
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['id'] = this.id;
    json['fullname'] = this.fullname;
    json['email'] = this.email;
    json['password'] = this.password;
    json['username'] = this.username;
    json['role_id'] = this.roleId;
    json['is_pending'] = this.isPending;
    json['is_deleted'] = this.isDeleted;
    json['role_name'] = this.roleName;
    json['created_at'] = this.createdAt;
    if (this.permissions != null) {
      json['permissions'] = this.permissions;
    }
    json['token'] = this.token;
    return json;
  }
}
