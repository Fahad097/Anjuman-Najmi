class Permissions {
  String? appDashboard;
  String? appDashboardReceipt;
  String? appReceipt;
  String? appUser;
  String? appUserRole;
  String? appReceiptPaid;
  Permissions(
      {this.appDashboard,
      this.appDashboardReceipt,
      this.appReceipt,
      this.appUser,
      this.appUserRole,
      this.appReceiptPaid});

  Permissions.fromJson(Map<String, dynamic> json) {
    appDashboard = json['app.dashboard'];
    appDashboardReceipt = json['app.dashboard.receipt'];
    appReceipt = json['app.receipt'];
    appUser = json['app.user'];
    appUserRole = json['app.user_role'];
    appReceiptPaid = json['app.receipt.paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app.dashboard'] = this.appDashboard;
    data['app.dashboard.receipt'] = this.appDashboardReceipt;
    data['app.receipt'] = this.appReceipt;
    data['app.user'] = this.appUser;
    data['app.user_role'] = this.appUserRole;
    data['app.receipt.paid'] = this.appReceiptPaid;
    return data;
  }
}
