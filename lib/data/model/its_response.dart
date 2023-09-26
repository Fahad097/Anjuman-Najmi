class ItsResponse {
  int? statusCode;
  Data? data;

  ItsResponse({this.statusCode, this.data});

  ItsResponse.fromJson(Map<String, dynamic> json) {
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
  int? mohallahId;
  int? markazId;
  String? markazName;
  String? mohallahName;
  String? name;
  String? email;
  String? mobile;
  String? imageUrl;
  String? address;
  String? gender;
  String? telephone;

  Data(
      {this.mohallahId,
      this.markazId,
      this.markazName,
      this.mohallahName,
      this.name,
      this.email,
      this.mobile,
      this.imageUrl,
      this.address,
      this.gender,
      this.telephone});

  Data.fromJson(Map<String, dynamic> json) {
    mohallahId = json['mohallah_id'];
    markazId = json['markaz_id'];
    markazName = json['markaz_name'];
    mohallahName = json['mohallah_name'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    imageUrl = json['image_url'];
    address = json['address'];
    gender = json['gender'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mohallah_id'] = this.mohallahId;
    data['markaz_id'] = this.markazId;
    data['markaz_name'] = this.markazName;
    data['mohallah_name'] = this.mohallahName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['image_url'] = this.imageUrl;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['telephone'] = this.telephone;
    return data;
  }
}
