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
}
