import 'package:anjuman_e_najmi/data/model/receipt_model.dart';

class ViewReceiptResposne {
  int? statusCode;
  TotalReceipt? totalReceipt;

  ViewReceiptResposne({this.statusCode, this.totalReceipt});

  ViewReceiptResposne.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    totalReceipt =
        json['data'] != null ? new TotalReceipt.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.totalReceipt != null) {
      data['data'] = this.totalReceipt!.toJson();
    }
    return data;
  }
}

class TotalReceipt {
  int? total;
  List<ReceiptModel>? data;

  TotalReceipt({this.total, this.data});

  TotalReceipt.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = <ReceiptModel>[];
      json['data'].forEach((v) {
        data!.add(new ReceiptModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
