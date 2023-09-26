class ReceiptModel {
  int? itsNumber;
  String? hubAmount;
  String? hubDate;
  String? fullname;
  int? hubType;
  int? paymentMode;
  int? receiptNumber;
  int? mohallaId;
  int? zabihatCount;
  int? markazId;
  int? isDeposited;
  String? depositDate;
  int? createdBy;
  String? createdOn;
  int? id;
  String? msg;
  String? receiptCode;
  ReceiptModel(
      {this.itsNumber,
      this.hubAmount,
      this.msg,
      this.receiptCode,
      this.hubDate,
      this.fullname,
      this.hubType,
      this.paymentMode,
      this.receiptNumber,
      this.mohallaId,
      this.zabihatCount,
      this.markazId,
      this.isDeposited,
      this.depositDate,
      this.createdBy,
      this.createdOn,
      this.id});

  ReceiptModel.fromJson(Map<String, dynamic> json) {
    itsNumber = json['its_number'];
    msg = json['msg'];
    fullname = json['fullname'];
    hubAmount = json['hub_amount'];
    receiptNumber = json['receipt_number'];
    hubDate = json['hub_date'];
    hubType = json['hub_type'];
    paymentMode = json['payment_mode'];
    receiptCode = json['receipt_code'];
    mohallaId = json['mohalla_id'];
    zabihatCount = json['zabihat_count'];
    markazId = json['markaz_id'];
    isDeposited = json['is_deposited'];
    depositDate = json['deposit_date'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['its_number'] = this.itsNumber;
    data['fullname'] = this.fullname;
    data['hub_amount'] = this.hubAmount;
    data['hub_date'] = this.hubDate;
    data['hub_type'] = this.hubType;
    data['payment_mode'] = this.paymentMode;
    data['receipt_number'] = this.receiptNumber;
    data['mohalla_id'] = this.mohallaId;
    data['zabihat_count'] = this.zabihatCount;
    data['markaz_id'] = this.markazId;
    data['receipt_code'] = this.receiptCode;
    data['is_deposited'] = this.isDeposited;
    data['deposit_date'] = this.depositDate;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['msg'] = this.msg;
    data['id'] = this.id;
    return data;
  }
}
