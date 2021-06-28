import 'dart:convert';


class ResponseData {
  ResponseData({
     this.data,
     this.errorCode,
     this.errorMsg,
  });

  factory ResponseData.fromJson(Map<String, dynamic> jsonRes) => ResponseData(
    data: jsonRes['data'],
    errorCode: jsonRes['errorCode'],
    errorMsg: jsonRes['errorMsg'],
  );

  dynamic data;
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
