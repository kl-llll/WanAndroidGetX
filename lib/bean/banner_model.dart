
import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }

  return null;
}

class BannerModel {
  BannerModel({
    this.data,
    this.errorCode,
    this.errorMsg,
  });

  factory BannerModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<BannerData>? data =
    jsonRes['data'] is List ? <BannerData>[] : null;
    if (data != null) {
      for (final dynamic item in jsonRes['data']!) {
        if (item != null) {
          data.add(BannerData.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return BannerModel(
      data: data,
      errorCode: asT<int?>(jsonRes['errorCode']),
      errorMsg: asT<String?>(jsonRes['errorMsg']),
    );
  }

  List<BannerData>? data;
  int? errorCode;
  String? errorMsg;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'data': data,
    'errorCode': errorCode,
    'errorMsg': errorMsg,
  };
  @override
  String toString() {
    return jsonEncode(this);
  }
}

class BannerData {
  BannerData({
    this.desc,
    this.id,
    this.imagePath,
    this.isVisible,
    this.order,
    this.title,
    this.type,
    this.url,
  });

  factory BannerData.fromJson(Map<String, dynamic> jsonRes) => BannerData(
    desc: asT<String?>(jsonRes['desc']),
    id: asT<int?>(jsonRes['id']),
    imagePath: asT<String?>(jsonRes['imagePath']),
    isVisible: asT<int?>(jsonRes['isVisible']),
    order: asT<int?>(jsonRes['order']),
    title: asT<String?>(jsonRes['title']),
    type: asT<int?>(jsonRes['type']),
    url: asT<String?>(jsonRes['url']),
  );

  String? desc;
  int? id;
  String? imagePath;
  int? isVisible;
  int? order;
  String? title;
  int? type;
  String? url;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'desc': desc,
    'id': id,
    'imagePath': imagePath,
    'isVisible': isVisible,
    'order': order,
    'title': title,
    'type': type,
    'url': url,
  };
  @override
  String toString() {
    return jsonEncode(this);
  }
}
