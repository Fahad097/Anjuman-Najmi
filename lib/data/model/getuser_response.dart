import 'package:anjuman_e_najmi/data/model/user_model.dart';

class GetUserResponse {
  int? statusCode;
  List<UserModel>? userModel;

  GetUserResponse({this.statusCode, this.userModel});

  GetUserResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      userModel = <UserModel>[];
      json['data'].forEach((v) {
        userModel!.add(new UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.userModel != null) {
      data['data'] = this.userModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
