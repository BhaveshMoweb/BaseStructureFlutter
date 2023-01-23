///    Created By Bhavesh Makwana on 20/01/23
class ThemePreferences {
  bool darkTheme = false;
//   static const PREF_KEY = 'pref_key';

  setTheme(bool value) {
    darkTheme = value;
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setBool(PREF_KEY, value);
  }

  getTheme() {
    return darkTheme;
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getBool(PREF_KEY) ?? false;
  }
}
