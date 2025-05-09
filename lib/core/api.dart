class Api {
  // server host url
  static const hostUrl = "http://192.168.2.100";
  static const hostConnection = "$hostUrl/clothes_app";
  static const userConn = "$hostConnection/user";
  static const adminConn = "$hostConnection/admin";

  /// User portion
  static const validateEmail = "$userConn/validate_email.php";
  static const signUp = "$userConn/sign_up.php";
  static const logIn = "$userConn/login.php";
  static const favouriteItems = "$userConn/favourite_items.php";
  static const searchItems = "$userConn/search_items.php";

  ///  Admin portion
  static const adminLogin = "$adminConn/login.php";
  static const adminTotalUsers = "$adminConn/total_users.php";
  static const adminUploadItemData = "$adminConn/item_data.php";
  static const adminGetItem = "$adminConn/get_item.php";
  static const adminUsersData = "$adminConn/users_info.php";
}
