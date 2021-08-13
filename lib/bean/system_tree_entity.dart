import 'package:wan_android_getx/generated/json/base/json_convert_content.dart';

class SystemTreeEntity with JsonConvert<SystemTreeEntity> {
	List<SystemTreeChildren>? children;
	double? courseId;
	double? id;
	String? name;
	double? order;
	double? parentChapterId;
	bool? userControlSetTop;
	double? visible;
}

class SystemTreeChildren with JsonConvert<SystemTreeChildren> {
	List<dynamic>? children;
	double? courseId;
	double? id;
	String? name;
	double? order;
	double? parentChapterId;
	bool? userControlSetTop;
	double? visible;
}
