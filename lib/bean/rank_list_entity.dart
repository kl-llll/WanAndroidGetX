import 'package:wan_android_getx/generated/json/base/json_convert_content.dart';

class RankListEntity with JsonConvert<RankListEntity> {
	int? curPage;
	List<RankListDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
}

class RankListDatas with JsonConvert<RankListDatas> {
	int? coinCount;
	int? level;
	String? nickname;
	String? rank;
	int? userId;
	String? username;
}
