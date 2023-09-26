import 'package:anjuman_e_najmi/data/repository/access_repository.dart';
import 'package:anjuman_e_najmi/logic/cubit/access/access_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessCubit extends Cubit<AccessState> {
  AccessCubit() : super(AccessState(accesses: []));

  final accessRepository = AccessRepository();

  final accessToNum = {"w": 3, "r": 2, "n": 1};

  getAccesses() async {
    emit(state.copyWith(isLoading_: true));

    final accessList = await accessRepository.getRoleAccesses();

    emit(state.copyWith(accesses_: accessList));
  }

  updateAccess(int index, String newAccess, {int childIndex = 10}) {
    // childIndex = 10 means only the parent access needs to be changed.
    if (childIndex == 10) {
      state.accesses?[index].access = newAccess;
      if (state.accesses![index].childResources != null) {
        for (int i = 0;
            i < state.accesses![index].childResources!.length;
            i++) {
          if (accessToNum[state.accesses?[index].access]! <
              accessToNum[state.accesses?[index].childResources![i].access]!) {
            state.accesses?[index].childResources![i].access =
                state.accesses![index].access!;
          }
        }
        print(state.accesses![index].toJson());
      }

      print(state.accesses?[index].toJson());
    } else {
      if (accessToNum[state.accesses?[index].access]! >=
          accessToNum[newAccess]!) {
        state.accesses?[index].childResources?[childIndex].access = newAccess;
        print(state.accesses?[index].childResources?[childIndex].toJson());
      } else {
        print("Not Allowed");
      }
    }
    emit(state.copyWith(accesses_: state.accesses));
  }
}
