import 'dart:convert';


class ResponseData {
  ResponseData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory ResponseData.fromJson(Map<String, dynamic> jsonRes) => ResponseData(
    data: jsonRes['data']!,
    errorCode: jsonRes['errorCode']!,
    errorMsg: jsonRes['errorMsg']!,
  );

  String data;
  int errorCode;
  String errorMsg;

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
