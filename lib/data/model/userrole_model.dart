class UserRoleModel {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? code;
  String? updatedAt;
  int? parent;
  int? isDeleted;

  UserRoleModel(
      {this.id,
      this.code,
      this.name,
      this.parent,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.isDeleted});

  UserRoleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['parent'] = this.parent;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}
