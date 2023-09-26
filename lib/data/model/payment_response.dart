class PaymentResponse {
  int? statusCode;
  List<Payment>? payment;

  PaymentResponse({this.statusCode, this.payment});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      payment = <Payment>[];
      json['data'].forEach((v) {
        payment!.add(new Payment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.payment != null) {
      data['data'] = this.payment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payment {
  int? id;
  String? code;
  String? title;
  int? isDeleted;

  Payment({this.id, this.code, this.title, this.isDeleted});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    title = json['title'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['title'] = this.title;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}
