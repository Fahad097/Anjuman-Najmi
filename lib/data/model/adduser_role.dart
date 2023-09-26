import 'package:anjuman_e_najmi/data/model/userrole_model.dart';

class AddUserRoleModel {
  int? statusCode;
  Data? data;

  AddUserRoleModel({this.statusCode, this.data});

  AddUserRoleModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? description;
  int? id;
  String? createdAt;
  String? updatedAt;
  List<UserRoleModel>? oldData;
  List<Permissions>? permissions;

  Data({this.name, this.description, this.id, this.oldData, this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
    if (json['old_data'] != null) {
      oldData = <UserRoleModel>[];
      // json['old_data'].forEach((v) {
      //   oldData!.add(new UserRoleModel.fromJson(v));
      // });
    }
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.oldData != null) {
      data['old_data'] = this.oldData!.map((v) => v.toJson()).toList();
    }
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  int? id;
  String? name;
  String? code;
  int? parent;
  String? createdAt;
  String? updatedAt;
  String? permission;

  Permissions(
      {this.id,
      this.name,
      this.code,
      this.parent,
      this.createdAt,
      this.updatedAt,
      this.permission});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    parent = json['parent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    permission = json['permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['parent'] = this.parent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['permission'] = this.permission;
    return data;
  }
}
