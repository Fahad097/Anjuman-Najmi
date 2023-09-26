import '../model/access_model.dart';

class AccessProvider {
  Future<List<AccessModel>> getRoleAccesses() async {
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
        "permission": "w",
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
        "permission": "w",
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
        "permission": "w",
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
}
