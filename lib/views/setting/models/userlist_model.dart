import '../../../utils/asset_config.dart';

class Userlistmodel {
  String receipttype;
  final String image;
  String icon;
  final String text;
  String status;
  
  Userlistmodel(
      this.receipttype, this.image, this.icon, this.text, this.status);
  
  static List<Userlistmodel> fetchAll() {
    return [
      Userlistmodel(
        "ReceiptType 1",
        AssetConfig.kmonitor_Icon,
        AssetConfig.knoaccess_Icon,
        "Dashboard",
        "No Access",
      ),
      Userlistmodel(
        "Receipt Type 2",
        AssetConfig.kReceiptIcon,
        AssetConfig.kreadaccess_Icon,
        "Receipt",
        "No Access",
      ),
      Userlistmodel(
        "Receipt Type 2",
        AssetConfig.kReportIcon,
        AssetConfig.kreadaccess_Icon,
        "Report",
        "Read Access",
      ),
      Userlistmodel(
        "Receipt Type 2",
        AssetConfig.krprofile_Icon,
        AssetConfig.kreadwrite_Icon,
        "Profile",
        "Read-Write Access",
      ),
      Userlistmodel(
        "Receipt Type 2",
        AssetConfig.kBudgetIcon,
        AssetConfig.knoaccess_Icon,
        "View Budget",
        "No Access",
      ),
      Userlistmodel(
        "Receipt Type 2",
        AssetConfig.kcbudget_Icon,
        AssetConfig.knoaccess_Icon,
        "Create Budget",
        "No Access",
      ),
      Userlistmodel(
        "Receipt Type 2",
        AssetConfig.kupload_Icon,
        AssetConfig.knoaccess_Icon,
        "Uploaded Files",
        "No Access",
      ),
    ];
  }
}
