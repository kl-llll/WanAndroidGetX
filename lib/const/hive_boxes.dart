import 'package:hive_flutter/hive_flutter.dart';

const String boxPrefix = 'wanAndroid';

class HiveBoxes {
  const HiveBoxes._();

  static late Box<bool> loginBox;

  static late Box<bool> darkBox;

  static late Box<List<String>> searchBox;

  static Future<void> openBoxes() async {
    // Hive..registerAdapter(HistorySearchAdapter());

    await Future.wait(<Future<void>>[
      () async {
        loginBox = await Hive.openBox("${boxPrefix}_login");
      }(),
      () async {
        darkBox = await Hive.openBox("${boxPrefix}_dark");
      }(),
      () async {
        searchBox = await Hive.openBox("${boxPrefix}_search");
      }(),
    ]);
  }
}
