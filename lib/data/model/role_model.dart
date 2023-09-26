

class RoleModel {
  int? id;
  String? name;

  RoleModel(this.id, this.name);

  factory RoleModel.fromJson(Map<String, dynamic> role) {
    int id_ = role["id"];
    String roleName = role["name"];

    return RoleModel(id_, roleName);
  }
}
