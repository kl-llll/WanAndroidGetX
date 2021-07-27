import 'package:wan_android_getx/generated/json/base/json_convert_content.dart';

class ProjectTreeEntity with JsonConvert<ProjectTreeEntity> {
	List<dynamic>? children;
	double? courseId;
	int? id;
	String? name;
	double? order;
	double? parentChapterId;
	bool? userControlSetTop;
	double? visible;
}
