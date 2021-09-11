
import 'package:hive/hive.dart';

part  'history_search_entity.g.dart';



@HiveType(typeId: 0)
class HistorySearch extends HiveObject {
  @HiveField(0)
  late String key;
}
