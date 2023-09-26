class AccessModel {
  int? id;
  String? name;
  String? code;
  String? access;
  List<AccessModel>? childResources;

  AccessModel(this.id, this.name, this.code, this.access, this.childResources);

  factory AccessModel.fromJson(Map<String, dynamic> access) {
    return AccessModel(
        access["id"], access["name"], access["code"], access["permission"], []);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "code": code,
      "permission": access,
    };
  }
}
