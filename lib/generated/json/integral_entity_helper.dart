import 'package:wan_android_getx/bean/integral_entity.dart';

integralEntityFromJson(IntegralEntity data, Map<String, dynamic> json) {
	if (json['coinCount'] != null) {
		data.coinCount = json['coinCount'] is String
				? int.tryParse(json['coinCount'])
				: json['coinCount'].toInt();
	}
	if (json['level'] != null) {
		data.level = json['level'] is String
				? int.tryParse(json['level'])
				: json['level'].toInt();
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['rank'] != null) {
		data.rank = json['rank'].toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
	}
	if (json['username'] != null) {
		data.username = json['username'].toString();
	}
	return data;
}

Map<String, dynamic> integralEntityToJson(IntegralEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['coinCount'] = entity.coinCount;
	data['level'] = entity.level;
	data['nickname'] = entity.nickname;
	data['rank'] = entity.rank;
	data['userId'] = entity.userId;
	data['username'] = entity.username;
	return data;
}