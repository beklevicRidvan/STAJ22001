import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static final SharedPreferencesUtil _singleton = SharedPreferencesUtil._internal();

  static SharedPreferences? _prefs;

  factory SharedPreferencesUtil() => _singleton;

  //Keys
  static const String eMail = 'email';
  static const String fullName = 'fullName';
  static const String userId = 'userId';
  static const String locale = 'locale';
  static const String balance = 'balance';
  static const String profImage = 'profImage';


  SharedPreferencesUtil._internal() {
    _init();
  }

  _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  remove(String key) => _prefs!.remove(key);
  removeAll() async => await _prefs!.clear();



  static Future<void> ensureInitialized() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  setString(String key, String value) => _prefs!.setString(key, value);
  String? getString(String key) => _prefs!.getString(key);

  setBool(String key, bool value) => _prefs!.setBool(key, value);
  bool? getBool(String key) => _prefs!.getBool(key);

  setInt(String key, int value) => _prefs!.setInt(key, value);
  int? getInt(String key) => _prefs!.getInt(key);



  setUserId(String value) => _prefs!.setString(userId, value);
  String? getUserId() => _prefs!.getString(userId);

  setEmail(String value) => _prefs!.setString(eMail, value);
  String? getEmail() => _prefs!.getString(eMail);

  setFullName(String value) => _prefs!.setString(fullName, value);
  String? getFullName() => _prefs!.getString(fullName);

  setBalance(double value) => _prefs!.setDouble(balance, value);
  double? getBalance() => _prefs!.getDouble(balance);

  setLocale(String value) => _prefs!.setString(locale, value);
  String? getLocale() => _prefs!.getString(locale);

  setImage(String value) => _prefs!.setString(profImage, value);
  String? getImage() => _prefs!.getString(profImage);


  clear() {
    _prefs!.clear();
  }
}