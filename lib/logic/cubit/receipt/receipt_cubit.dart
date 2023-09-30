import 'dart:developer';
import 'package:anjuman_e_najmi/data/model/Receipt_url_pdf.dart';
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
    var formattedStringSplit;
    formattedStringSplit = amount.split('.');
    var formattedString = formattedStringSplit[0];

    emit(state.copywith(aamount: formattedString));
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
          response.receiptModel?.receiptNumber != null) {
        int lastnumber = response.receiptModel?.receiptNumber ?? 0;
        emit(state.copywith(
            rreceiptNumber: lastnumber,
            rreceiptCode: response.receiptModel?.receiptCode));
      }
    });
  }

  ItsResponse itsList = ItsResponse();
  itsnumber(context, int id) async {
    await receiptRepository.itsNumber(id).then((value) {
      final response = ItsResponse.fromJson(value);
      int s = response.statusCode ?? 0;
      print("TTT$s}");
      if (response.statusCode != null &&
          response.statusCode == 200 &&
          id != 0) {
        emit(state.copywith(iisCheck: true));
        emit(state.copywith(
            mmarkazId: response.data?.markazId,
            mmohallaId: response.data?.mohallahId,
            iitsNumber: state.itsNumber,
            nname: response.data?.name,
            iitsStatuscode: s,
            mmohallah: response.data?.mohallahName,
            iimageUrl: response.data?.imageUrl));
      }
    });
  }

  getReceiptURL(int id) async {
    print('in');
    emit(state.copywith(iisloading: true));
    await receiptRepository.getPDF(id).then((value) {
      final response = ReceiptPdf.fromJson(value);
      print("Result  getpdf: $response");
      if (response.statusCode != null && response.statusCode == 200) {
        print("${response.data!.url}");

        emit(
            state.copywith(rreceiptPDF: response.data!.url, iisloading: false));
      }
    }).onError((error, stackTrace) {
      Globals.showToast('There is issue with url');
      emit(state.copywith(iisloading: false));
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
    print(
        "www  ${state.itsNumber} ${state.name}${state.amount} ${state.dateController?.text.toString()} ${state.hubType}${state.paymentMode} ${state.mohallaId} ${authCub.getuserID}  ${state.markazId} ${state.zabihatCount} ${state.isDeposit}");
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
      "zabihat_count": state.zabihatCount,
    };
    emit(state.copywith(iisloading: true));
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
            aamount: response.receiptModel?.hubAmount,
            zzabihatCount: response.receiptModel?.zabihatCount,
            iitsNumber: response.receiptModel?.itsNumber,
            rreceiptCode: response.receiptModel?.receiptCode,
            mmarkazId: response.receiptModel?.markazId,
            mmohallaId: response.receiptModel?.mohallaId,
            ddateController: controller,
            iisloading: false));
        Globals.showToast("Receipt is Edit");
        getpaid(Globals.unpaid == "unpaid" ? Globals.unpaid : Globals.paid,
            limit: 20);
      }
    }).onError((error, stackTrace) {
      Globals.showToast("Invalid ITS Number");

      emit(state.copywith(iisloading: false));
    });
  }

  int i = 0;
  markpaid(context, List<ReceiptModel> receipt, int index) async {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    print(
        "www  ${receipt[index].receiptCode} ${receipt[index].itsNumber} ${receipt[index].hubAmount} ${receipt[index].createdOn} ${receipt[index].markazId} ${receipt[index].hubType} ${receipt[index].paymentMode} ${receipt[index].fullname}  ${receipt[index].markazId}  ${receipt[index].zabihatCount} ${receipt[index].createdBy}");

    Map<String, dynamic> variable = {
      "receipt_number": receipt[index].receiptCode,
      "its_number": receipt[index].itsNumber,
      "hub_amount": receipt[index].hubAmount,
      "hub_date": receipt[index].createdOn,
      "hub_type": receipt[index].hubType,
      "payment_mode": receipt[index].paymentMode,
      "fullname": receipt[index].fullname,
      "mohalla_id": receipt[index].mohallaId,
      "user_id": authCub.getuserID,
      "markaz_id": receipt[index].markazId,
      "zabihat_count": receipt[index].zabihatCount,
      "is_deposited": 1
    };
    emit(state.copywith(iisloading: true));
    await receiptRepository
        .editReceipt(receipt[index].id ?? 0, variable)
        .then((value) {
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
            iisloading: false,
            ddateController: controller));
      }
      Globals.showToast("Receipt is Paid");
    }).onError((error, stackTrace) {
      Globals.showToast("Receipt Not Paid");
      emit(state.copywith(iisloading: true));
    });
  }

  markUnpaid(context, List<ReceiptModel> receipt, int index) async {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);

    Map<String, dynamic> variable = {
      "receipt_number": receipt[index].receiptCode,
      "its_number": receipt[index].itsNumber,
      "hub_amount": receipt[index].hubAmount,
      "hub_date": receipt[index].createdOn,
      "hub_type": receipt[index].hubType,
      "payment_mode": receipt[index].paymentMode,
      "fullname": receipt[index].fullname,
      "mohalla_id": receipt[index].mohallaId,
      "user_id": authCub.getuserID,
      "markaz_id": receipt[index].markazId,
      "zabihat_count": receipt[index].zabihatCount,
      "is_deposited": 0
    };
    emit(state.copywith(iisloading: true));
    await receiptRepository
        .editReceipt(receipt[index].id ?? 0, variable)
        .then((value) {
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
            iisloading: false,
            ddateController: controller));
      }
      Globals.showToast("Receipt is Unpaid");
    }).onError((error, stackTrace) {
      Globals.showToast("Receipt Not Unpaid");
      emit(state.copywith(iisloading: false));
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
        newreceiptList = dd.map((item) {
          return ReceiptModel(
            id: item.id,
            receiptNumber: item.receiptNumber,
            receiptCode: item.receiptCode,
            itsNumber: item.itsNumber,
            fullname: item.fullname,
            hubAmount: item.hubAmount,
            hubDate: item.hubDate,
            mohallaId: item.mohallaId,
            hubType: item.hubType,
            zabihatCount: item.zabihatCount,
            markazId: item.markazId,
            isDeposited: item.isDeposited,
            depositDate: item.depositDate,
            createdBy: item.createdBy,
            createdOn: item.createdOn,
            isDeleted: item.isDeleted,
            paymentMode: item.paymentMode,
            mohallahName: item.mohallahName,
            hubTypeName: item.hubTypeName,
            paymentTitle: item.paymentTitle,
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
    debugPrint(" offset: ${state.offset}");
  }

  addReceipts(
    context,
  ) async {
    final authCub = BlocProvider.of<AuthCubit>(context, listen: false);
    emit(state.copywith(iisloading: true));
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
      "zabihat_count": state.zabihatCount,
      "is_deposited": state.isDeposit
    };
    await receiptRepository.addReceipt(variable).then((value) {
      final response = ReceiptResponse.fromJson(value);
      if (response.statusCode != null && response.statusCode == 200) {
        TextEditingController controller = TextEditingController.fromValue(
          TextEditingValue(text: "${response.receiptModel?.depositDate}"),
        );
        print("${controller.toString()}");
        emit(state.copywith(
            aamount: response.receiptModel?.hubAmount,
            zzabihatCount: response.receiptModel?.zabihatCount,
            iitsNumber: response.receiptModel?.itsNumber,
            rreceiptCode: response.receiptModel?.receiptCode,
            mmarkazId: response.receiptModel?.markazId,
            mmohallaId: response.receiptModel?.mohallaId,
            iisDeposit: response.receiptModel?.isDeposited,
            ddateController: controller,
            iisloading: false));
        Globals.showToast("Receipt is Created");

        resetReceipt();
      }
    }).onError((error, stackTrace) {
      Globals.showToast("Invalid ITS Number");

      emit(state.copywith(iisloading: false));
    });
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
