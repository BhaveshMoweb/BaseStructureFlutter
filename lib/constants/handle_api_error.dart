/*
  Handle error while calling API
*/
import '../utils/strings.dart';

class HandleAPI {
  static String handleAPIError(e) {
    try {
      if (e.toString().contains(
          "(OS Error: No address associated with hostname, errno = 7)")) {
        return Strings.noInternet;
      }
      return e.toString();
    } catch (e) {
      return Strings.somethingWentWrong;
    }
  }
}
