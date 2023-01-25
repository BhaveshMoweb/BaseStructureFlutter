/// Strings class
class Label {
  /// ******************* Screen Wise Texts ***********************
  /// Login Screen
  static const String login = "Login";
  static const String email = "Email";
  static const String password = "Password";

  /// no internet screen
  static const String internetConnectionLost = "Internet Connection Lost";
  static const String noInternetDesc =
      "Please check you internet connection and try again later.";
  static const String tryAgain = "Try Again";
  static const String youAreOffline = "You're Offline";
  static const String youAreOnline = "You're Online";

  /// product list screen
  static const String productList = "Product List";

  /// Post list Screen
  static const String posts = "Posts";

  /// No data found screen
  static const String noDataFound = "No Data Found";

  /// ******************* Other Texts ***********************

  /// other common strings
  static const String noInternet = "No Internet Connection!";
  static const String somethingWentWrong = "Something Went Wrong!";

  /// error message
  static const String errEmptyEmail = "Please enter email";
  static const String errInvalidEmail = "Please enter valid email";
  static const String errEmptyPassword = "Please enter password";

  /// success messages
  static const String loginSuccessMessage = "Login successfully done";
}

/// shared preference keys
class Pref {
  static String langCode = "LANGUAGE_CODE";
  static String isInternetConnection = "internet_connection";
  static String isLoggedIn = "isLoggedIn";
}
