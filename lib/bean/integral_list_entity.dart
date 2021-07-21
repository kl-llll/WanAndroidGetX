import 'package:wan_android_getx/generated/json/base/json_convert_content.dart';

class IntegralListEntity with JsonConvert<IntegralListEntity> {
	int? curPage;
	List<IntegralListDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
}

class IntegralListDatas with JsonConvert<IntegralListDatas> {
	int? coinCount;
	int? date;
	String? desc;
	int? id;
	String? reason;
	int? type;
	int? userId;
	String? userName;
}
