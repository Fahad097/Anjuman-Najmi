import 'package:flutter/cupertino.dart';
import '../model/receipt_model.dart';
import '../provider/receipt_provider.dart';

class ReceiptRepository {
  final provider = ReceiptProvider();

  Future addReceipt(Map<String, dynamic> variable) async {
    final result = await provider.addReceipt(variable);
    debugPrint("${result.toString()}");
    return result;
  }

  Future editReceipt(int id, Map<String, dynamic> variable) async {
    final result = await provider.editReceipt(id, variable);
    debugPrint("${result.toString()}");
    return result;
  }

  Future lastReceiptNumber() async {
    final result = await provider.lastReceiptNumber();
    debugPrint("lastReceiptNumber Repository ${result.toString()}");
    return result;
  }

  Future itsNumber(int id) async {
    final result = await provider.itsNumber(id);
    debugPrint("ItstNumber Repository ${result.toString()}");
    return result;
  }

  Future fetchData(Map<String, dynamic> variable) async {
    final result = await provider.fetchData();
    debugPrint("Repository ${result.toString()}");
    return result;
  }

  Future getReceipt(int id) async {
    final result = await provider.getReceipt(id);
    debugPrint("Repository ${result.toString()}");
    return result;
  }

  Future deleteReceipt(int id) async {
    final result = await provider.deleteReceipt(id);
    debugPrint("Repository ${result.toString()}");
    return result;
  }

  Future getPayment() async {
    final result = await provider.getPayment();
    debugPrint("Repository ${result.toString()}");
    return result;
  }

  Future getHubType() async {
    final result = await provider.getHubType();
    debugPrint("Repository ${result.toString()}");
    return result;
  }

  Future getReceiptpaid(Map<String, dynamic> queryParameters) async {
    debugPrint("Repository $queryParameters");
    final result = await provider.getReceiptpaid(queryParameters);
    debugPrint("Repository ${result.toString()}");
    return result;
  }

  Future getReceiptAll() async {
    final result = await provider.getReceiptall();
    debugPrint("Repository ${result.toString()}");
    return result;
  }

  Future getReceiptAllPaid() async {
    final result = await provider.getReceiptallPaid();
    debugPrint("Repository ${result.toString()}");
    return result;
  }

  List<ReceiptModel>? receiptdetail() {
    return provider.receiptdetail();
  }
}
