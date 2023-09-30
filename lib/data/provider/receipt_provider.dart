import 'package:anjuman_e_najmi/network/api_urls.dart';
import 'package:flutter/cupertino.dart';
import '../../network/service_helper.dart';
import '../model/receipt_model.dart';

class ReceiptProvider {
  // 'https://64b78d4f21b9aa6eb078534c.mockapi.io/receipt'
  Future addReceipt(Map<String, dynamic> variable) async {
    debugPrint("${ApiUrls.addreceipt}");
    return await ServiceHelper.postApiCall(ApiUrls.addreceipt, variable);
  }

  Future editReceipt(int id, Map<String, dynamic> variable) async {
    debugPrint("${ApiUrls.editreceipt + id.toString()}");
    return await ServiceHelper.putApiCall(
        ApiUrls.editreceipt + id.toString(), variable);
  }

  Future lastReceiptNumber() async {
    debugPrint("${ApiUrls.lastReceiptNumber}");
    return await ServiceHelper.getApiCall(ApiUrls.lastReceiptNumber);
  }

  Future itsNumber(int id) async {
    debugPrint("${ApiUrls.itsNumber + id.toString()}");
    return await ServiceHelper.getApiCall(ApiUrls.itsNumber + id.toString());
  }

  Future fetchData() async {
    return await ServiceHelper.getApiCall(
      ApiUrls.receipt,
    );
  }

  Future getReceipt(int id) async {
    debugPrint("ReceiptNumber ${ApiUrls.getreceiptid + id.toString()}");
    return await ServiceHelper.getApiCall(
      ApiUrls.getreceiptid + id.toString(),
    );
  }

  Future getPDF(int id) async {
    debugPrint("pdf id ${ApiUrls.getReceiptPDF + id.toString()}");
    return await ServiceHelper.getApiCall(
      ApiUrls.getReceiptPDF + id.toString(),
    );
  }

  Future deleteReceipt(int id) async {
    debugPrint("ReceiptNumber ${ApiUrls.getreceiptid + id.toString()}");
    return await ServiceHelper.deleteApiCall(
      ApiUrls.deleteReceipt + id.toString(),
    );
  }

  Future getPayment() async {
    return await ServiceHelper.getApiCall(
      ApiUrls.paymentmode,
    );
  }

  Future getHubType() async {
    return await ServiceHelper.getApiCall(
      ApiUrls.hubtype,
    );
  }

  Future getReceiptpaid(Map<String, dynamic> queryParameters) async {
    debugPrint(ApiUrls.getreceiptpaid);
    return await ServiceHelper.getApiCallParams(
        ApiUrls.getreceiptpaid, queryParameters);
  }

  Future getReceiptall() async {
    return await ServiceHelper.getApiCall(ApiUrls.getreceiptallunpaid);
  }

  Future getReceiptallPaid() async {
    return await ServiceHelper.getApiCall(ApiUrls.getreceiptallpaid);
  }

  List<ReceiptModel>? receiptdetail() {
    var resp = [
      {
        "id": "11",
        "payment_type": "Cash",
        "name": "Shabbir",
        "mohallah": "zainee",
        "select_date": 1692087091,
        "receipt_type": "Receipt 2",
        "amount": 3400,
        "receipt_made_by": "Mulla hakimuddin"
      }
    ];
    List<ReceiptModel> receiptdetail = [];

    if (resp.length > 0) {
      for (int i = 0; i < resp.length; i++) {
        final receiptdetai = ReceiptModel.fromJson(resp[i]);
        receiptdetail.add(receiptdetai);
      }
    }

    return receiptdetail;
  }
}
