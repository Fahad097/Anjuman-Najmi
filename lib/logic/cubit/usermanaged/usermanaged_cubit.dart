import 'package:flutter_bloc/flutter_bloc.dart';
part 'usermanaged_state.dart';

class UserManagedCubit extends Cubit<UserManagedState> {
  UserManagedCubit()
      : super(UserManagedState(
            title: '', addcheck: false, addlist: [], amount: 0, remarks: ""));
  title(String title) {
    emit(state.copywith(
      ttitle: title,
    ));
  }

  remarks(String rema) {
    emit(state.copywith(
      ttitle: rema,
    ));
  }

  amount(int amount) {
    emit(state.copywith(
      aamount: amount,
    ));
  }

  void addcheck(bool addchec) {
    addchec = !state.addcheck!;
    emit(state.copywith(aaddcheck: addchec));
  }

  void addListitem({required bool isCheck}) {
    var maplist = {'amount': state.amount, 'remarks': state.remarks};
    emit(state.copywith(aaddlist: state.addlist?..add(maplist)));
    print("liset");
    print("www ${state.addlist.toString()}");
  }

  void delete(int index) {
    print("xxxx " + state.addlist.toString());
    emit(state.copywith(aaddlist: state.addlist?..removeAt(index)));
  }
}
