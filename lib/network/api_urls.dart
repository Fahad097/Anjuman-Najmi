class ApiUrls {
  static String baseUrl = "http://34.239.93.196/api/";
  //"https://64b78d4f21b9aa6eb078534c.mockapi.io/";
  static String signin = "${baseUrl}login";
  static String signup = "${baseUrl}register";
  static String adduser = "${baseUrl}register";
  static String receipt = "${baseUrl}receipt";
  static String addreceipt = "${baseUrl}receipt";
  static String editreceipt = "${baseUrl}receipt/";
  static String paymentmode = "${baseUrl}payment_mode";
  static String hubtype = "${baseUrl}hub_type";
  static String lastReceiptNumber = "${baseUrl}receipt/last_number";
  static String itsNumber = "${baseUrl}receipt/its_user/";
  static String deleteAccount = "${baseUrl}user/";
  static String deleteReceipt = "${baseUrl}receipt/";
  static String editprofile = "${baseUrl}user/";
  static String getprofile = "${baseUrl}user/";
  static String getAlluser = "${baseUrl}user";
  static String getreceiptid = "${baseUrl}receipt/";
  static String getreceiptunpaid =
      "${baseUrl}receipt?type=paid&limit=10&offset=0}";
  //  http://34.239.93.196/api/receipt?type=paid&limit=10&offset=0
  static String getreceiptpaid = "${baseUrl}receipt";
  static String getreceiptallpaid =
      "${baseUrl}receipt?type=paid&limit=10&offset=0";

  static String getreceiptallunpaid =
      "${baseUrl}receipt?type=unpaid&limit=10&offset=0";
  static String getuserole = "${baseUrl}user_role";
  //${RoleCubit.userrolebyid != null ? RoleCubit.userrolebyid : 0}
  static String getuserRoleId = "${baseUrl}user_role/";
  static String edituserrole = "${baseUrl}user_role/";
  static String adduserRole = "${baseUrl}user_role";
  static String deleteuserrole = "${baseUrl}user_role/";
  static String permissions = "${baseUrl}user_role/permissions";
}

enum ReceiptType { paid, unpaid }
