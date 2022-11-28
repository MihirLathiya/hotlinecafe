import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();
  static String name = "name";
  static String mobile = "mobile";
  static String userId = "userId";
  static String userName = "userName";
  static String loginStatus = "loginStatus";
  static String device_id = "deviceId";
  static String latitude = "latitude";
  static String longitude = "longitude";
  static String image = "userImage";
  static String type = "socialtype";
  static String rate = "rate";
  static String currentBalance = "currentBalance";

  ///Device Id
  static Future setDeviceId(String value) async {
    await getStorage.write(device_id, value);
  }

  static getDeviceId() {
    return getStorage.read(device_id);
  }

  ///currentBalance
  static Future setCurrentBalance(String value) async {
    await getStorage.write(currentBalance, value);
  }

  static getCurrentBalance() {
    return getStorage.read(currentBalance);
  }

  ///Device Id
  static Future setRate(String value) async {
    await getStorage.write(rate, value);
  }

  static getRate() {
    return getStorage.read(rate);
  }

  ///social_type
  static Future setType(String value) async {
    await getStorage.write(type, value);
  }

  static String getType() {
    return getStorage.read(type);
  }

  ///User Image
  static Future setUserImage(String value) async {
    await getStorage.write(image, value);
  }

  static String getUserImage() {
    return getStorage.read(image);
  }

  ///Name
  static Future setName(String value) async {
    await getStorage.write(name, value);
  }

  static String getName() {
    return getStorage.read(name);
  }

  ///Latitude
  static Future setLatitude(String value) async {
    await getStorage.write(latitude, value);
  }

  static String getLatitude() {
    return getStorage.read(latitude);
  }

  ///Longitude
  static Future setLongitude(String value) async {
    await getStorage.write(longitude, value);
  }

  static String getLongitude() {
    return getStorage.read(longitude);
  }

  ///mobile
  static Future setMobile(String value) async {
    await getStorage.write(mobile, value);
  }

  static String getMobile() {
    return getStorage.read(mobile);
  }

  ///user id
  static Future setUserId(String value) async {
    await getStorage.write(userId, value);
  }

  static getUserId() {
    return getStorage.read(userId);
  }

  ///user Name
  static Future setUserName(String value) async {
    await getStorage.write(userName, value);
  }

  static String getUserName() {
    return getStorage.read(userName);
  }

  /// Login status
  static Future setLogin(bool value) async {
    await getStorage.write(loginStatus, value);
  }

  static getLogin() {
    return getStorage.read(loginStatus);
  }

  static Future getClear() {
    return getStorage.erase();
  }
}
