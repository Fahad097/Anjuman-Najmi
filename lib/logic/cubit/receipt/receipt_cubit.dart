import 'dart:developer';
import 'package:anjuman_e_najmi/data/model/its_response.dart';
import 'package:anjuman_e_najmi/data/model/payment_response.dart';
import 'package:anjuman_e_najmi/data/model/receipt_response.dart';
import 'package:anjuman_e_najmi/data/model/viewReceipt_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/Hubtype_model.dart';
import '../../../data/model/receipt_model.dart';
import '../../../data/repository/receipt_repository.dart';
import '../../../network/api_urls.dart';
import '../../../utils/global_constants.dart';
import '../authentication/auth_cubit.dart';
part 'receipt_state.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit()
      : super(ReceiptState(
            isCheck: false,
            itsNumber: 0,
            dateController: TextEditingController(),
            mohallah: "",
            isDeposit: 0,
            receiptNumber: 0,
            isloading: false,
            offset: 0,
            oldReceiptList: [],
            receipt: [],
            paymentMode: 0,
            hubType: 0,
            amount: "",
            selectDate: ""));
  final receiptRepository = ReceiptRepository();
  void check(bool check) {
    check = !state.isCheck!;
    emit(state.copywith(iisCheck: check));
  }

  receiptdetails() {
    var receiptdetail = receiptRepository.receiptdetail();

    emit(state.copywith(rreceipt: receiptdetail));
  }

  selectedDate(String number) {
    emit(state.copywith(sselectDate: number));
  }

  paymentMode(int r) {
    emit(state.copywith(ppaymentMode: r));
    print("paymentMode ${state.paymentMode}");
  }

  hubType(int r) {
    emit(state.copywith(hhubType: r, zzabihatCount: state.zabihatCount));
    print("hubType ${state.hubType}");
  }

  isZabihat(int r) {
    emit(state.copywith(iiszzabihat: r));
    print("  zabihatCount ${state.iszabihat}");
  }

  zabihatCount(int r) {
    emit(state.copywith(zzabihatCount: r));
    print("  zabihatCount ${state.zabihatCount}");
  }

  itsNumber(int number) {
    emit(state.copywith(iitsNumber: number));
    debugPrint(state.itsNumber.toString());
  }

  amount(String amount) {
    double parsedDouble = double.parse(amount); // Parse the string as a double
    int decimalPlaces = 2; // Specify the desired number of decimal places

// Round the double to the desired number of decimal places
    double roundedDouble =
        double.parse(parsedDouble.toStringAsFixed(decimalPlaces));

// Convert the rounded double back to a string
    String formattedString = roundedDouble.toString();

    print(formattedString);
    emit(state.copywith(aamount: formattedString));
  }

  mohallah(String m) {
    emit(state.copywith(mmohallah: m));
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      String selectedDate =
          "${picked.day.toString()}/${picked.month.toString()}/${picked.year.toString()}";
      state.dateController?.text = selectedDate;
      emit(state.copywith(ddateController: state.dateController));
    }
  }

  lastReceiptNumber() async {
    await receiptRepository.lastReceiptNumber().then((value) {
      final response = ReceiptResponse.fromJson(value);
      if (response.statusCode != null &&
              response.statusCode == 200 &&
              response.receiptModel?.receiptNumber != null
          // response.receiptModel?.receiptNumber
          // !=response.receiptModel?.receiptNumber
          ) {
        int lastnumber = response.receiptModel?.receiptNumber ?? 0;
        emit(state.copywith(
            rreceiptNumber: lastnumber,
            rreceiptCode: response.receiptModel?.receiptCode));
      }
    });
  }

  static int? itsNumb;
  ItsResponse itsList = ItsResponse();
  itsnumber(context, int id) async {
    await receiptRepository.itsNumber(id).then((value) {
      final response = ItsResponse.fromJson(value);
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          id != 0) {
        emit(state.copywith(iisCheck: true));
        emit(state.copywith(
            mmarkazId: response.data?.markazId,
            mmohallaId: response.data?.mohallahId,
            iitsNumber: state.itsNumber,
            nname: response.data?.name,
            mmohallah: response.data?.mohallahName,
            iimageUrl: response.data?.imageUrl));
      }
    });
  }

  Map<String, dynamic> map = {};
  getReceipt(int id) async {
    await receiptRepository.getReceipt(id).then((value) {
      final response = ReceiptResponse.fromJson(value);
      log("Result  getReceipt: $response");
      if (response.statusCode != null && response.statusCode == 200) {
        TextEditingController controller = TextEditingController.fromValue(
          TextEditingValue(text: "${response.receiptModel?.createdOn}"),
        );

        List<ReceiptModel> listData = [];

        listData.add(response.receiptModel!);

        print(listData);
        emit(state.copywith(
            iid: response.receiptModel?.id,
            rreceiptNumber: response.receiptModel?.receiptNumber,
            rreceiptCode: response.receiptModel?.receiptCode,
            ddateController: controller,
            ppaymentMode: response.receiptModel?.paymentMode,
            aamount: response.receiptModel?.hubAmount,
            rreceipt: listData));
      }
    });
  }

  deleteReceipt(int id) async {
    await receiptRepository.deleteReceipt(id).then((value) {
      final response = ReceiptResponse.fromJson(value);
      log("Result  getReceipt: $response");

      if (response.statusCode != null && response.statusCode == 200) {
        emit(state.copywith(
          iid: response.receiptModel?.id,
        ));
        // Globals.showToast(response.receiptModel?.msg ?? "");
      }
    });
  }

  List<Payment> paymentist = [];
  getPayment() async {
    await receiptRepository.getPayment().then((value) {
      final response = PaymentResponse.fromJson(value);
      int i = 0;
      if (response.statusCode != null && response.statusCode == 200) {
        paymentist.clear();
        paymentist.addAll(response.payment!);
        emit(state.copywith(
          ppaymentList: paymentist,
          //ppaymentModeId: response.payment?[i].id
        ));
        log("GetPayment: ${response.payment![i].id}");
      }
    });
  }

  List<HubModel> hubtypelist = [];
  getHubType() async {
    await receiptRepository.getHubType().then((value) {
      final esponse = HubModel.fromJson(value);
      final response = HubTypeResponse.fromJson(value);
      log("Result  getHubType: $response  tt ${esponse.id.toString()}");
      int index = 0;
      if (response.statusCode != null && response.statusCode == 200) {
        hubtypelist.clear();
        hubtypelist.addAll(response.hubModel!);

        emit(state.copywith(
            hhubtypelist: hubtypelist,
            //  hhubtypeId: response.hubModel?[i].id,
            zzabihatCount: response.hubModel?[i].isZabihat));
        log("GGGGGG ${state.hubtypelist?[index].id} ${response.hubModel?[i].isZabihat}");
      }
    });
  }

  List<TotalReceipt> totalreceiptList = [];
  getReceiptAll() async {
    await receiptRepository.getReceiptAll().then((value) {
      final response = ViewReceiptResposne.fromJson(value);

      log("Result  getReceipt: $response");
      if (response.statusCode != null && response.statusCode == 200) {
        totalreceiptList.clear();
        totalreceiptList.add(response.totalReceipt!);

        emit(state.copywith(
            ttotalreceipt: totalreceiptList,
            rreceipt: response.totalReceipt?.data));
      }
    });
  }

  getReceiptAllPaid() async {
    await receiptRepository.getReceiptAllPaid().then((value) {
      final response = ViewReceiptResposne.fromJson(value);

      log("Result  getReceipt: $response");
      if (response.statusCode != null && response.statusCode == 200) {
        totalreceiptList.clear();
        totalreceiptList.add(response.totalReceipt!);
        emit(state.copywith(
            ttotalreceipt: totalreceiptList,
            rreceipt: response.totalReceipt?.data));
      }
    });
  }

  editReceipts(context, int id) async {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: Globals.kUniversal)));

    Map<String, dynamic> variable = {
      "receipt_number": state.receiptCode,
      "its_number": state.itsNumber,
      "fullname": state.name,
      "hub_amount": state.amount,
      "hub_date": state.dateController?.text,
      "hub_type": state.hubType,
      "user_id": authCub.getuserID,
      "payment_mode": state.paymentMode,
      "mohalla_id": state.mohallaId,
      "markaz_id": state.markazId,
      //"zabihat_count": state.hubtypelist?[i].isZabihat,
      "zabihat_count": state.zabihatCount,
      "is_deposited": state.isDeposit
    };
    await receiptRepository
        .editReceipt(
      id,
      variable,
    )
        .then((value) {
      final response = ReceiptResponse.fromJson(value);

      log("Result: $response");
      if (response.statusCode != null && response.statusCode == 200) {
        TextEditingController controller = TextEditingController.fromValue(
          TextEditingValue(text: "${response.receiptModel?.depositDate}"),
        );
        log("Result: $value   date $controller");

        emit(state.copywith(
            rreceiptCode: response.receiptModel?.receiptCode,
            iitsNumber: response.receiptModel?.itsNumber,
            aamount: response.receiptModel?.hubAmount,
            iid: response.receiptModel?.id,
            zzabihatCount: response.receiptModel?.zabihatCount,
            iisDeposit: response.receiptModel?.isDeposited,
            mmarkazId: response.receiptModel?.markazId,
            mmohallaId: response.receiptModel?.mohallaId,
            ddateController: controller));
      }
    });
    Navigator.pop(context);
    Navigator.pop(context);
  }

  // getReceiptpaid({int limit = 10, int offset = 0}) async {
  //   Map<String, dynamic> variable = {'limit': limit, 'offset': state.offset};
  //   await receiptRepository.getReceiptpaid(variable).then((value) {
  //     final response = ReceiptResponse.fromJson(value);
  //     log("Result  getReceiptpaid: $response");
  //     if (response.receiptModel != null) {
  //       if (response.statusCode != null && response.statusCode == 200) {
  //         receiptList.clear();
  //         receiptList.add(response.receiptModel!);

  //         emit(state.copywith(rreceipt: receiptList));
  //       }
  //     }
  //   });
  // }
  int i = 0;
  markpaid(context, int id) async {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: Globals.kUniversal)));

    Map<String, dynamic> variable = {
      "receipt_number": state.receiptCode,
      "its_number": state.itsNumber,
      "hub_amount": state.amount,
      "hub_date": state.dateController?.text.toString(),
      "hub_type": state.hubType,
      "payment_mode": state.paymentMode,
      "fullname": state.name,
      "mohalla_id": state.mohallaId,
      "user_id": authCub.getuserID,
      "markaz_id": state.markazId,
      "zabihat_count": state.zabihatCount,
      "is_deposited": 1
    };
    await receiptRepository.editReceipt(id, variable).then((value) {
      final response = ReceiptResponse.fromJson(value);

      log("Result: $response");
      if (response.statusCode != null && response.statusCode == 200) {
        TextEditingController controller = TextEditingController.fromValue(
          TextEditingValue(text: "${response.receiptModel?.depositDate}"),
        );
        debugPrint(response.receiptModel?.isDeposited.toString());
        emit(state.copywith(
            iisDeposit: response.receiptModel?.isDeposited,
            iid: response.receiptModel?.id,
            zzabihatCount: response.receiptModel?.zabihatCount,
            iitsNumber: response.receiptModel?.itsNumber,
            aamount: response.receiptModel?.hubAmount,
            rreceiptCode: response.receiptModel?.receiptCode,
            mmarkazId: response.receiptModel?.markazId,
            mmohallaId: response.receiptModel?.mohallaId,
            ddateController: controller));
      }
    });
  }

  markUnpaid(context, int id) async {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: Globals.kUniversal)));

    Map<String, dynamic> variable = {
      "receipt_number": state.receiptCode,
      "its_number": state.itsNumber,
      "hub_amount": state.amount,
      "hub_date": state.dateController?.text.toString(),
      "hub_type": state.hubType,
      "payment_mode": state.paymentMode,
      "fullname": state.name,
      "mohalla_id": state.mohallaId,
      "user_id": authCub.getuserID,
      "markaz_id": state.markazId,
      "zabihat_count": state.zabihatCount,
      "is_deposited": 0
    };
    await receiptRepository.editReceipt(id, variable).then((value) {
      final response = ReceiptResponse.fromJson(value);

      log("Result: $response");
      if (response.statusCode != null && response.statusCode == 200) {
        TextEditingController controller = TextEditingController.fromValue(
          TextEditingValue(text: "${response.receiptModel?.depositDate}"),
        );
        debugPrint(response.receiptModel?.isDeposited.toString());
        emit(state.copywith(
            iisDeposit: response.receiptModel?.isDeposited,
            zzabihatCount: response.receiptModel?.zabihatCount,
            iid: response.receiptModel?.id,
            iitsNumber: response.receiptModel?.itsNumber,
            aamount: response.receiptModel?.hubAmount,
            rreceiptCode: response.receiptModel?.receiptCode,
            mmarkazId: response.receiptModel?.markazId,
            mmohallaId: response.receiptModel?.mohallaId,
            ddateController: controller));
      }
    });
  }

  getpaid(String value, {int limit = 2, int offset = 0}) async {
    emit(state.copywith(ooldReceiptList: []));
    List<ReceiptModel> newreceiptList = [];
    state.oldReceiptList?.addAll(state.receipt!);
    if (state.offset! > 0) {
      emit(state.copywith(iisloading: true));
    }
    Map<String, dynamic> variable = {
      "type": "$value",
      'limit': "$limit",
      'offset': "${state.offset}"
    };
    await receiptRepository.getReceiptpaid(variable).then((value) {
      debugPrint(ApiUrls.getreceiptpaid + variable.toString());
      final response = ViewReceiptResposne.fromJson(value);
      final dd = response.totalReceipt!.data;
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          dd != null) {
        //   newreceiptList.clear();
        // if (!state.oldReceiptList!.any((element) => element.id == dd[i].id)) {
        //   newreceiptList.add(ReceiptModel(
        //     id: dd[i].id,
        //     receiptCode: dd[i].receiptCode,
        //     fullname: dd[i].fullname,
        //     createdBy: dd[i].createdBy,
        //     createdOn: dd[i].createdOn,
        //   ));
        // }

        // for (i; i < dd!.length; i++) {
        //   newreceiptList.add(ReceiptModel(
        //     id: dd[i].id,
        //     receiptNumber: dd[i].receiptNumber,
        //     receiptCode: dd[i].receiptCode,
        //     itsNumber: dd[i].itsNumber,
        //     fullname: dd[i].fullname,
        //     hubAmount: dd[i].hubAmount,
        //     hubDate: dd[i].hubDate,
        //     mohallaId: dd[i].mohallaId,
        //     hubType: dd[i].hubType,
        //     zabihatCount: dd[i].zabihatCount,
        //     markazId: dd[i].markazId,
        //     isDeposited: dd[i].isDeposited,
        //     depositDate: dd[i].depositDate,
        //     paymentMode: dd[i].paymentMode,
        //     createdBy: dd[i].createdBy,
        //     createdOn: dd[i].createdOn,
        //   ));

        newreceiptList = dd.map((item) {
          return ReceiptModel(
            receiptCode: item.receiptCode,
            fullname: item.fullname,
            createdBy: item.createdBy,
            createdOn: item.createdOn,
          );
        }).toList();

        debugPrint(ApiUrls.getreceiptpaid + variable.toString());
        state.oldReceiptList?.addAll(newreceiptList);
        debugPrint(state.oldReceiptList?.length.toString());
        emit(state.copywith(
          rreceipt: state.oldReceiptList,
          iisloading: false,
        ));
      }
    });
  }

  updateOffSet() {
    emit(state.copywith(ooffset: state.offset! + 2));
    debugPrint("Updated offset: ${state.offset}");
  }

  resetOffSet() {
    emit(state.copywith(ooffset: 0));
  }

  addReceipts(
    context,
  ) async {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
            child: CircularProgressIndicator(color: Globals.kUniversal)));

    Map<String, dynamic> variable = {
      "receipt_number": state.receiptCode,
      "its_number": state.itsNumber,
      "fullname": state.name,
      "hub_amount": state.amount,
      "hub_date": state.dateController?.text.toString(),
      "hub_type": state.hubType,
      "payment_mode": state.paymentMode,
      "mohalla_id": state.mohallaId,
      "user_id": authCub.getuserID,
      "markaz_id": state.markazId,
      //"zabihat_count": state.hubtypelist?[i].isZabihat,
      "zabihat_count": state.zabihatCount,
      "is_deposited": state.isDeposit
    };
    {}

    await receiptRepository.addReceipt(variable).then((value) {
      final response = ReceiptResponse.fromJson(value);
      if (response.statusCode != null && response.statusCode == 200) {
        TextEditingController controller = TextEditingController.fromValue(
          TextEditingValue(text: "${response.receiptModel?.depositDate}"),
        );
        emit(state.copywith(
            aamount: response.receiptModel?.hubAmount,
            zzabihatCount: response.receiptModel?.zabihatCount,
            iitsNumber: response.receiptModel?.itsNumber,
            rreceiptCode: response.receiptModel?.receiptCode,
            mmarkazId: response.receiptModel?.markazId,
            mmohallaId: response.receiptModel?.mohallaId,
            iisDeposit: response.receiptModel?.isDeposited,
            ddateController: controller));
      }
    });
    Globals.showToast("Receipt is Created");
    Navigator.pop(context);
    resetReceipt();
  }

  resetReceipt() {
    emit(ReceiptState(
        isCheck: false,
        itsNumber: 0,
        dateController: TextEditingController(),
        mohallah: "",
        receiptNumber: 0,
        offset: 0,
        oldReceiptList: [],
        receipt: [],
        amount: "",
        paymentMode: 0,
        selectDate: ""));
  }

  getPendingReceiptLoader() {
    emit(state.copywith(ppendingReceiptState: 'searching'));
  }
}
