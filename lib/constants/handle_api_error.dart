/*
  Handle error while calling API
*/
import '../utils/strings.dart';

class HandleAPI {
  static String handleAPIError(e) {
    try {
      if (e.toString().contains(
          "(OS Error: No address associated with hostname, errno = 7)")) {
        return Label.noInternet;
      }
      return e.toString();
    } catch (e) {
      return Label.somethingWentWrong;
    }
  }
}
