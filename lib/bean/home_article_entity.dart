import 'package:wan_android_getx/generated/json/base/json_convert_content.dart';

class HomeArticleEntity with JsonConvert<HomeArticleEntity> {
	int? curPage;
	List<HomeArticleDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
}

class HomeArticleDatas with JsonConvert<HomeArticleDatas> {
	String? apkLink;
	int? audit;
	String? author;
	bool? canEdit;
	int? chapterId;
	String? chapterName;
	bool? collect;
	int? courseId;
	String? desc;
	String? descMd;
	String? envelopePic;
	bool? fresh;
	String? host;
	int? id;
	String? link;
	String? niceDate;
	String? niceShareDate;
	String? origin;
	String? prefix;
	String? projectLink;
	int? publishTime;
	int? realSuperChapterId;
	int? selfVisible;
	int? shareDate;
	String? shareUser;
	int? superChapterId;
	String? superChapterName;
	List<HomeArticleDatasTags>? tags;
	String? title;
	int? type;
	int? userId;
	int? visible;
	int? zan;

}

class HomeArticleDatasTags with JsonConvert<HomeArticleDatasTags> {
	String? name;
	String? url;
}
