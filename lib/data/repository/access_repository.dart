import 'package:anjuman_e_najmi/data/provider/access_provider.dart';


class AccessRepository {
  final accessProvider = AccessProvider();

  Future getRoleAccesses() async {
    final result = await accessProvider.getRoleAccesses();
    return result;
  }
}
