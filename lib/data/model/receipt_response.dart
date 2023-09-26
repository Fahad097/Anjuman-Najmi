import 'package:anjuman_e_najmi/data/model/receipt_model.dart';

class ReceiptResponse {
  int? statusCode;
  ReceiptModel? receiptModel;

  ReceiptResponse({this.statusCode, this.receiptModel});

  ReceiptResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    receiptModel =
        json['data'] != null ? new ReceiptModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.receiptModel != null) {
      data['data'] = this.receiptModel?.toJson();
    }
    return data;
  }
}
