import 'package:anjuman_e_najmi/data/model/user_model.dart';

class LoginResponse {
  int? statusCode;
  UserModel? userModel;

  LoginResponse({this.statusCode, this.userModel});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    userModel =
        json['data'] != null ? new UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.userModel != null) {
      data['data'] = this.userModel!.toJson();
    }
    return data;
  }

  static List<LoginResponse> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return LoginResponse.fromJson(data);
    }).toList();
  }
}
