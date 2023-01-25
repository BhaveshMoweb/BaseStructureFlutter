///    Created By Bhavesh Makwana on 20/01/23
class ThemePreferences {
  bool darkTheme = false;

  setTheme(bool value) async {
    darkTheme = value;
  }

  getTheme() {
    return darkTheme;
  }
}
