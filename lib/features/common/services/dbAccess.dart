import 'package:hive_flutter/hive_flutter.dart';

class DbAccess {
  static late Box personalBox;

  static Box get userDB => personalBox;

  static Future initHive() async =>
      await Hive.initFlutter().then((_) async => await initDB());

  static Future<Box> initDB() async =>
      personalBox = await Hive.openBox("personal");

  static dynamic readData(String key, {dynamic defaultValue}) =>
      userDB.get(key, defaultValue: defaultValue) ?? defaultValue;

  static Future writeData(String key, dynamic value) => userDB.put(key, value);

  static Future deleteData(String key) => userDB.delete(key);
}
