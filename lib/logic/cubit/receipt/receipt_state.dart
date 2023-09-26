part of 'receipt_cubit.dart';

class ReceiptState {
  String? mohallah;
  int? itsNumber;
  List<ReceiptModel>? receipt;
  List<Payment>? paymentList;
  List<HubModel>? hubtypelist;
  String? amount;
  final int? receiptNumber;
  final String? receiptCode;
  final int? id;
  final String? name;
  final int? offset;
  List? itemList;
  final int? mohallaId;
  final int? markazId;
  final bool? isloading;
  ItsResponse? itslist;
  bool? isCheck;
  final int? isDeposit;
  int? iszabihat;
  final TextEditingController? dateController;
  List<ReceiptModel>? oldReceiptList;
  List<TotalReceipt>? totalreceipt;
  int? paymentMode;
  int? hubType;
  int? zabihatCount;
  String? selectDate;
  String? imageUrl;
  final String? ppendingReceiptState;

  ReceiptState(
      {this.paymentMode,
      this.ppendingReceiptState,
      this.hubtypelist,
      this.zabihatCount,
      this.name,
      this.imageUrl,
      this.receiptCode,
      this.itemList,
      this.iszabihat,
      this.markazId,
      this.mohallaId,
      this.paymentList,
      this.itslist,
      this.hubType,
      this.isDeposit,
      this.oldReceiptList,
      this.offset,
      this.isloading,
      this.id,
      this.receiptNumber,
      this.totalreceipt,
      this.dateController,
      this.mohallah,
      this.amount,
      this.itsNumber,
      this.selectDate,
      this.isCheck,
      this.receipt});

  ReceiptState copywith({
    String? mmohallah,
    final String? ppendingReceiptState,
    String? sselectDate,
    int? hhubType,
    int? zzabihatCount,
    int? iiszzabihat,
    String? iimageUrl,
    List<Payment>? ppaymentList,
    List<HubModel>? hhubtypelist,
    final int? mmohallaId,
    final int? mmarkazId,
    final int? iisDeposit,
    final String? nname,
    final int? rreceiptNumber,
    final String? rreceiptCode,
    List<ReceiptModel>? rreceipt,
    int? ppaymentMode,
    List<TotalReceipt>? ttotalreceipt,
    ItsResponse? iitslist,
    String? aamount,
    final int? ooffset,
    final int? iid,
    final bool? iisloading,
    final List<ReceiptModel>? ooldReceiptList,
    final TextEditingController? ddateController,
    String? ttitle,
    bool? iisCheck,
    int? iitsNumber,
  }) {
    return ReceiptState(
      ppendingReceiptState: ppendingReceiptState ?? ppendingReceiptState,
      zabihatCount: zzabihatCount ?? zabihatCount,
      selectDate: sselectDate ?? selectDate,
      hubType: hhubType ?? hubType,
      paymentMode: ppaymentMode ?? paymentMode,
      hubtypelist: hhubtypelist ?? hubtypelist,
      amount: aamount ?? amount,
      id: iid ?? id,
      iszabihat: iiszzabihat ?? iszabihat,
      imageUrl: iimageUrl ?? imageUrl,
      markazId: mmarkazId ?? markazId,
      mohallaId: mmohallaId ?? mohallaId,
      name: nname ?? name,
      itslist: iitslist ?? itslist,
      isDeposit: iisDeposit ?? isDeposit,
      mohallah: mmohallah ?? mohallah,
      totalreceipt: ttotalreceipt ?? totalreceipt,
      isloading: iisloading ?? isloading,
      itsNumber: iitsNumber ?? itsNumber,
      oldReceiptList: ooldReceiptList ?? oldReceiptList,
      receipt: rreceipt ?? receipt,
      paymentList: ppaymentList ?? paymentList,
      receiptCode: rreceiptCode ?? receiptCode,
      receiptNumber: rreceiptNumber ?? receiptNumber,
      offset: ooffset ?? offset,
      dateController: ddateController ?? this.dateController,
      isCheck: iisCheck ?? isCheck,
    );
  }
}
