import 'package:anjuman_e_najmi/network/service_helper.dart';
import 'package:flutter/cupertino.dart';
import '../../network/api_urls.dart';
import '../model/access_model.dart';
import '../model/user_model.dart';

class AuthProvider {
  Future signup(Map<String, dynamic> variable) async {
    return await ServiceHelper.postApiCall(ApiUrls.adduser, variable);
  }

  Future addUser(Map<String, dynamic> variable) async {
    return await ServiceHelper.postApiCall(ApiUrls.signup, variable);
  }
  // final url = Uri.parse(ApiUrls.signup
  //     // 'https://64b78d4f21b9aa6eb078534c.mockapi.io/signin'
  //     ); // Replace with the actual REST API endpoint for createProfile
  // final headers = {'Content-Type': 'application/json'};

  // try {
  //   final response = await http.post(url,
  //       headers: ApiUrls.headers, body: jsonEncode(variable));
  //   if (response.statusCode == 200) {
  //     // Success
  //     return await jsonDecode(response.body);
  //   } else {
  //     // Handle errors
  //     print("Status ${response.statusCode}");
  //     Fluttertoast.showToast(msg: "Error Sign Up, Please try again!");
  //     return {'error': 'Error Sign Up'};
  //   }
  // } catch (e) {
  //   // Handle exceptions

  //   Fluttertoast.showToast(msg: "Exception occurred, Please try again!");
  //   return {'error': 'Exception occurred'};
  // }

  // Future signin(Map<String, dynamic> variable, String customer_id) async {
  //   final url = 'https://64b78d4f21b9aa6eb078534c.mockapi.io/signin';
  //   final queryParameters = {'customer_id': customer_id};

  //   // final url = Uri.parse(
  //   //     "https://64b78d4f21b9aa6eb078534c.mockapi.io/signin?customer_id=$customer_id"); // Replace with the actual REST API endpoint for createProfile
  //   final headers = {'Content-Type': 'application/json'};
  //   String queryString = Uri(queryParameters: queryParameters).query;
  //   var requestUrl = url + '?' + queryString + '=';
  //   print(requestUrl);
  //   final response = await http.get(Uri.parse(requestUrl), headers: headers);
  //   try {
  //     // final response = await http.get(
  //     //   url,
  //     //   headers: headers,
  //     // );
  //     if (response.statusCode == 200) {
  //       // Success
  //       debugPrint("WW ${jsonDecode(response.body)}");

  //       return await jsonDecode(response.body);
  //     } else {
  //       // Handle errors
  //       debugPrint("else error ${jsonDecode(response.body)}");
  //       Fluttertoast.showToast(msg: "Error Sign In, Please try again!");
  //       return {'error': 'Error Sign In'};
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: "Exception occurred, Please try again!");
  //     return {'error': 'Exception occurred'};
  //   }
  // }
  Future signin(Map<String, dynamic> variable) async {
    debugPrint(ApiUrls.signin);
    return await ServiceHelper.postApiCall(
        ApiUrls.signin,
        // 'https://64b78d4f21b9aa6eb078534c.mockapi.io/signin'

        variable);
  }

  Future deleteAccount(int id) async {
    debugPrint(ApiUrls.deleteAccount);
    return await ServiceHelper.deleteApiCall(
        ApiUrls.deleteAccount + id.toString());
  }

  Future getProfile(int id) async {
    debugPrint(ApiUrls.getprofile + id.toString());
    return await ServiceHelper.getApiCall(ApiUrls.getprofile + id.toString());
  }

  Future getAllUser() async {
    debugPrint(ApiUrls.getAlluser);
    return await ServiceHelper.getApiCall(ApiUrls.getAlluser);
  }

  Future editProfile(Map<String, dynamic> variable, int id) {
    debugPrint(ApiUrls.editprofile + id.toString());
    return ServiceHelper.putApiCall(
        ApiUrls.editprofile + id.toString(), variable);
  }

  List<AccessModel>? getRoleAccesses(int roleId) {
    // This roleId will be used to get role accesses.

    var resp = [
      {
        "id": 1,
        "name": "Dashboard",
        "code": "app.dashboard",
        "permission": "w",
      },
      {
        "id": 2,
        "name": "Dashboard Receipt",
        "code": "app.dashboard.receipt",
        "permission": "w",
      },
      {
        "id": 3,
        "name": "Dashboard Budget",
        "code": "app.dashboard.budget",
        "permission": "r",
      },
      {
        "id": 4,
        "name": "Receipt",
        "code": "app.receipt",
        "permission": "w",
      },
      {
        "id": 5,
        "name": "Receipt Pending",
        "code": "app.receipt.pending",
        "permission": "r",
      },
      {
        "id": 6,
        "name": "Receipt Paid Button",
        "code": "app.receipt.paid_btn",
        "permission": "w",
      },
      {
        "id": 7,
        "name": "Receipt Unpaid Button",
        "code": "app.receipt.unpaid_btn",
        "permission": "w",
      },
      {
        "id": 8,
        "name": "Budget",
        "code": "app.budget",
        "permission": "w",
      },
      {
        "id": 9,
        "name": "Report",
        "code": "app.report",
        "permission": "n",
      }
    ];

    List<AccessModel> userPermissions = [];

    Map codeToNum = {"dashboard": 0, "receipt": 1, "budget": 2, "report": 3};

    for (Map json in resp) {
      List code = json["code"].split(".");
      if (code.length == 2) {
        userPermissions.add(AccessModel(
            json["id"], json["name"], json["code"], json["permission"], []));
      } else {
        userPermissions[codeToNum[code[1]]].childResources?.add(AccessModel(
            json["id"], json["name"], json["code"], json["permission"], []));
      }
    }

    return userPermissions;
  }

  Future<UserModel> loginUser() async {
    Map<String, dynamic> resp = {
      "user_id": 1,
      "name": "Muhammad",
      "role_id": 1
    };

    UserModel user = UserModel.fromJson(resp);
    return user;
  }
}
