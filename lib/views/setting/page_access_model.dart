import 'package:anjuman_e_najmi/views/setting/models/userlist_model.dart';

import '../../../utils/asset_config.dart';

class PageAccessModel {
  List<Userlistmodel> subPageFields;
  Userlistmodel mainPage;

  PageAccessModel(this.subPageFields, this.mainPage);

  static List<PageAccessModel> fetchAll() {
    return [
      PageAccessModel(
        [
          Userlistmodel(
            "ReceiptType 1",
            AssetConfig.kmonitor_Icon,
            AssetConfig.knoaccess_Icon,
            "Receipt",
            "No Access",
          ),
          Userlistmodel(
            "ReceiptType 1",
            AssetConfig.kmonitor_Icon,
            AssetConfig.knoaccess_Icon,
            "Budget",
            "No Access",
          ),
        ],
        Userlistmodel(
          "ReceiptType 1",
          AssetConfig.kmonitor_Icon,
          AssetConfig.knoaccess_Icon,
          "Dashboard",
          "No Access",
        ),
      ),
      PageAccessModel(
        [
          Userlistmodel(
            "ReceiptType 1",
            AssetConfig.kmonitor_Icon,
            AssetConfig.knoaccess_Icon,
            "UnPaid Button",
            "No Access",
          ),
          Userlistmodel(
            "ReceiptType 1",
            AssetConfig.kmonitor_Icon,
            AssetConfig.knoaccess_Icon,
            "Paid Button",
            "No Access",
          ),
        ],
        Userlistmodel(
          "Receipt Type 2",
          AssetConfig.kReceiptIcon,
          AssetConfig.kreadaccess_Icon,
          "Receipt",
          "No Access",
        ),
      ),
      PageAccessModel(
        [
          Userlistmodel(
            "Receipt Type 2",
            AssetConfig.kReceiptIcon,
            AssetConfig.kreadaccess_Icon,
            "Create",
            "No Access",
          ),
          Userlistmodel(
            "Receipt Type 2",
            AssetConfig.kReceiptIcon,
            AssetConfig.kreadaccess_Icon,
            "View",
            "No Access",
          ),
        ],
        Userlistmodel(
          "Receipt Type 2",
          AssetConfig.kReceiptIcon,
          AssetConfig.kreadaccess_Icon,
          "Budget",
          "No Access",
        ),
      )
    ];
  }
}