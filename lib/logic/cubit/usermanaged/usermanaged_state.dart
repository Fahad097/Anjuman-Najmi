part of 'usermanaged_cubit.dart';

class UserManagedState {
  String? title;
  List<String>? category;
  List<dynamic>? addlist;
  String? selectedCategory;
  int? amount;
  String? remarks;
  bool? addcheck;
  UserManagedState(
      {this.title,
      this.amount,
      this.remarks,
      this.category,
      this.selectedCategory,
      this.addcheck,
      this.addlist});

  UserManagedState copywith(
      {String? ttitle,
      List<dynamic>? aaddlist,
      int? aamount,
      String? rremarks,
      List<String>? ccategory,
      String? selectedCategory,
      bool? aaddcheck}) {
    return UserManagedState(
        addcheck: aaddcheck ?? this.addcheck,
        title: ttitle ?? title,
        addlist: aaddlist ?? addlist,
        amount: aamount ?? amount,
        remarks: rremarks ?? remarks,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        category: ccategory ?? category);
  }
}
