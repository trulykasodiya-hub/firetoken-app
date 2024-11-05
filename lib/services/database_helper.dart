import 'package:firetoken/model/notification_model.dart';
import 'package:hive/hive.dart';

var databaseHelper = DatabaseHelper();

/* Hive Init */
class DatabaseHelper {

  // Box Key
  static String get trueulyNews => "FireToken";
  static String get notification => "Notification";

  static Future initialize() async {
    await Hive.openBox(trueulyNews);
    await Hive.openBox(notification);
  }

  // for Notification Post Id
  /* Save Post In LocalStorage */
  static Future<dynamic> saveNotificationPost(NotificationModel data) async {
    final box = Hive.box(notification);
    return box.put(data.messageId.toString(), data.toJson());
  }

  /* Read Notification Articles In LocalStorage */
  static Future<List<Map<dynamic, dynamic>>> readNotificationPost() async {
    final box = Hive.box(notification);
    final res = box.values.whereType<Map<dynamic, dynamic>>().toList();
    return res;
  }

  /* Remove Article From Notifications */
  static Future<void> removeNotificationPost(int id) async {
    final box = Hive.box(notification);
    await box.delete(id.toString());
  }

  /* SignOut and Delete Storage */
  static Future deleteAll() async {
    final one = Hive.box(notification);
    final two = Hive.box(trueulyNews);
    await one.clear();
    await two.clear();
  }

}