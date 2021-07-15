import 'package:hive/hive.dart';
import 'package:wan_android_getx/generated/json/base/json_convert_content.dart';

class LoginEntity with JsonConvert<LoginEntity> {
	int? coinCount;
	int? level;
	String? nickname;
	String? rank;
	int? userId;
	String? username;
}
