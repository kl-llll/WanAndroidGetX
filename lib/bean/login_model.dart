import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }

  return null;
}

class LoginModel {
  LoginModel({
    this.admin,
    this.chapterTops,
    this.coinCount,
    this.collectIds,
    this.email,
    this.icon,
    this.id,
    this.nickname,
    this.password,
    this.publicName,
    this.token,
    this.type,
    this.username,
  });

  factory LoginModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<Object>? chapterTops =
    jsonRes['chapterTops'] is List ? <Object>[] : null;
    if (chapterTops != null) {
      for (final dynamic item in jsonRes['chapterTops']!) {
        if (item != null) {
          chapterTops.add(asT<Object>(item)!);
        }
      }
    }

    final List<int>? collectIds =
    jsonRes['collectIds'] is List ? <int>[] : null;
    if (collectIds != null) {
      for (final dynamic item in jsonRes['collectIds']!) {
        if (item != null) {
          collectIds.add(asT<int>(item)!);
        }
      }
    }
    return LoginModel(
      admin: asT<bool?>(jsonRes['admin']),
      chapterTops: chapterTops,
      coinCount: asT<int?>(jsonRes['coinCount']),
      collectIds: collectIds,
      email: asT<String?>(jsonRes['email']),
      icon: asT<String?>(jsonRes['icon']),
      id: asT<int?>(jsonRes['id']),
      nickname: asT<String?>(jsonRes['nickname']),
      password: asT<String?>(jsonRes['password']),
      publicName: asT<String?>(jsonRes['publicName']),
      token: asT<String?>(jsonRes['token']),
      type: asT<int?>(jsonRes['type']),
      username: asT<String?>(jsonRes['username']),
    );
  }

  bool? admin;
  List<Object>? chapterTops;
  int? coinCount;
  List<int>? collectIds;
  String? email;
  String? icon;
  int? id;
  String? nickname;
  String? password;
  String? publicName;
  String? token;
  int? type;
  String? username;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'admin': admin,
    'chapterTops': chapterTops,
    'coinCount': coinCount,
    'collectIds': collectIds,
    'email': email,
    'icon': icon,
    'id': id,
    'nickname': nickname,
    'password': password,
    'publicName': publicName,
    'token': token,
    'type': type,
    'username': username,
  };
  @override
  String toString() {
    return jsonEncode(this);
  }
}
