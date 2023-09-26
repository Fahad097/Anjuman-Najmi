import 'package:anjuman_e_najmi/data/model/userrole_model.dart';

class UserRoleRespsone {
  int? statusCode;
  List<UserRoleModel>? userRoleModel;

  UserRoleRespsone({this.statusCode, this.userRoleModel});

  // UserRoleRespsone.fromJson(Map<String, dynamic> json) {
  //   statusCode = json['statusCode'];
  //   if (json['data'] != null) {
  //     userRoleModel = <UserRoleModel>[];
  //     json['data'].forEach((v) {
  //       userRoleModel!.add(new UserRoleModel.fromJson(v));
  //     });
  //   }
  // }
  UserRoleRespsone.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null && json['data'] is List) {
      userRoleModel = <UserRoleModel>[];
      var dataList = json['data'] as List; // Now it's safe to cast as a List.
      for (var v in dataList) {
        userRoleModel!.add(new UserRoleModel.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.userRoleModel != null) {
      data['data'] = this.userRoleModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
