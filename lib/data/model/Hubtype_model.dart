class HubTypeResponse {
  int? statusCode;
  List<HubModel>? hubModel;

  HubTypeResponse({this.statusCode, this.hubModel});

  HubTypeResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      hubModel = <HubModel>[];
      json['data'].forEach((v) {
        hubModel!.add(new HubModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.hubModel != null) {
      data['data'] = this.hubModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HubModel {
  int? id;
  String? hubType;
  String? period;
  int? isZabihat;
  String? colorCode;
  String? bayanImage;
  int? enabled;
  String? headerText;

  HubModel(
      {this.id,
      this.hubType,
      this.period,
      this.isZabihat,
      this.colorCode,
      this.bayanImage,
      this.enabled,
      this.headerText});

  HubModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hubType = json['hub_type'];
    period = json['period'];
    isZabihat = json['is_zabihat'];
    colorCode = json['color_code'];
    bayanImage = json['bayan_image'];
    enabled = json['enabled'];
    headerText = json['header_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hub_type'] = this.hubType;
    data['period'] = this.period;
    data['is_zabihat'] = this.isZabihat;
    data['color_code'] = this.colorCode;
    data['bayan_image'] = this.bayanImage;
    data['enabled'] = this.enabled;
    data['header_text'] = this.headerText;
    return data;
  }
}
