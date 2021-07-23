import 'package:wan_android_getx/generated/json/base/json_convert_content.dart';

class CollectEntity with JsonConvert<CollectEntity> {
	int? curPage;
	List<CollectDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
}

class CollectDatas with JsonConvert<CollectDatas> {
	String? author;
	int? chapterId;
	String? chapterName;
	int? courseId;
	String? desc;
	String? envelopePic;
	int? id;
	String? link;
	String? niceDate;
	String? origin;
	int? originId;
	int? publishTime;
	String? title;
	int? userId;
	int? visible;
	int? zan;
}
