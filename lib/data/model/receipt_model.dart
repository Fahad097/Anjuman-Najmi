class ReceiptModel {
  int? id;
  int? receiptNumber;
  String? receiptCode;
  int? itsNumber;
  String? fullname;
  String? hubAmount;
  String? hubDate;
  int? mohallaId;
  int? hubType;
  int? zabihatCount;
  int? markazId;
  int? isDeposited;
  String? refNum;
  String? depositDate;
  int? paymentMode;
  String? createdBy;
  int? updatedBy;
  String? createdOn;
  String? updatedOn;
  int? isDeleted;
  String? paymentTitle;
  String? hubTypeName;
  String? mohallahName;
  String? markazName;
  String? imageUrl;
  String? name;
  String? msg;
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
      this.id,
      this.createdBy,
      this.updatedBy,
      this.createdOn,
      this.updatedOn,
      this.isDeleted,
      this.paymentTitle,
      this.hubTypeName,
      this.mohallahName,
      this.markazName,
      this.imageUrl,
      this.name});

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
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    isDeleted = json['is_deleted'];
    paymentTitle = json['payment_title'];
    hubTypeName = json['hub_type_name'];
    mohallahName = json['mohallah_name'];
    markazName = json['markaz_name'];
    imageUrl = json['image_url'];
    name = json['name'];
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
    data['msg'] = this.msg;
    data['id'] = this.id;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['is_deleted'] = this.isDeleted;
    data['payment_title'] = this.paymentTitle;
    data['hub_type_name'] = this.hubTypeName;
    data['hub_type_name'] = this.hubTypeName;
    data['mohallah_name'] = this.mohallahName;
    data['markaz_name'] = this.markazName;
    data['image_url'] = this.imageUrl;
    data['name'] = this.name;
    return data;
  }
}
