import 'package:wan_android_getx/bean/collect_entity.dart';

collectEntityFromJson(CollectEntity data, Map<String, dynamic> json) {
	if (json['curPage'] != null) {
		data.curPage = json['curPage'] is String
				? int.tryParse(json['curPage'])
				: json['curPage'].toInt();
	}
	if (json['datas'] != null) {
		data.datas = (json['datas'] as List).map((v) => CollectDatas().fromJson(v)).toList();
	}
	if (json['offset'] != null) {
		data.offset = json['offset'] is String
				? int.tryParse(json['offset'])
				: json['offset'].toInt();
	}
	if (json['over'] != null) {
		data.over = json['over'];
	}
	if (json['pageCount'] != null) {
		data.pageCount = json['pageCount'] is String
				? int.tryParse(json['pageCount'])
				: json['pageCount'].toInt();
	}
	if (json['size'] != null) {
		data.size = json['size'] is String
				? int.tryParse(json['size'])
				: json['size'].toInt();
	}
	if (json['total'] != null) {
		data.total = json['total'] is String
				? int.tryParse(json['total'])
				: json['total'].toInt();
	}
	return data;
}

Map<String, dynamic> collectEntityToJson(CollectEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['curPage'] = entity.curPage;
	data['datas'] =  entity.datas?.map((v) => v.toJson())?.toList();
	data['offset'] = entity.offset;
	data['over'] = entity.over;
	data['pageCount'] = entity.pageCount;
	data['size'] = entity.size;
	data['total'] = entity.total;
	return data;
}

collectDatasFromJson(CollectDatas data, Map<String, dynamic> json) {
	if (json['author'] != null) {
		data.author = json['author'].toString();
	}
	if (json['chapterId'] != null) {
		data.chapterId = json['chapterId'] is String
				? int.tryParse(json['chapterId'])
				: json['chapterId'].toInt();
	}
	if (json['chapterName'] != null) {
		data.chapterName = json['chapterName'].toString();
	}
	if (json['courseId'] != null) {
		data.courseId = json['courseId'] is String
				? int.tryParse(json['courseId'])
				: json['courseId'].toInt();
	}
	if (json['desc'] != null) {
		data.desc = json['desc'].toString();
	}
	if (json['envelopePic'] != null) {
		data.envelopePic = json['envelopePic'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['link'] != null) {
		data.link = json['link'].toString();
	}
	if (json['niceDate'] != null) {
		data.niceDate = json['niceDate'].toString();
	}
	if (json['origin'] != null) {
		data.origin = json['origin'].toString();
	}
	if (json['originId'] != null) {
		data.originId = json['originId'] is String
				? int.tryParse(json['originId'])
				: json['originId'].toInt();
	}
	if (json['publishTime'] != null) {
		data.publishTime = json['publishTime'] is String
				? int.tryParse(json['publishTime'])
				: json['publishTime'].toInt();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
	}
	if (json['visible'] != null) {
		data.visible = json['visible'] is String
				? int.tryParse(json['visible'])
				: json['visible'].toInt();
	}
	if (json['zan'] != null) {
		data.zan = json['zan'] is String
				? int.tryParse(json['zan'])
				: json['zan'].toInt();
	}
	return data;
}

Map<String, dynamic> collectDatasToJson(CollectDatas entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['author'] = entity.author;
	data['chapterId'] = entity.chapterId;
	data['chapterName'] = entity.chapterName;
	data['courseId'] = entity.courseId;
	data['desc'] = entity.desc;
	data['envelopePic'] = entity.envelopePic;
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['niceDate'] = entity.niceDate;
	data['origin'] = entity.origin;
	data['originId'] = entity.originId;
	data['publishTime'] = entity.publishTime;
	data['title'] = entity.title;
	data['userId'] = entity.userId;
	data['visible'] = entity.visible;
	data['zan'] = entity.zan;
	return data;
}