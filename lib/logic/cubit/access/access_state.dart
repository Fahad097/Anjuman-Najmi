import '../../../data/model/access_model.dart';

class AccessState {
  List<AccessModel>? accesses;
  bool? isLoading;
  AccessState({this.accesses, this.isLoading});

  AccessState copyWith({List<AccessModel>? accesses_, bool? isLoading_}) {
    return AccessState(accesses: accesses_ ?? accesses,
    isLoading: isLoading_ ?? isLoading  
    );
  }
}
