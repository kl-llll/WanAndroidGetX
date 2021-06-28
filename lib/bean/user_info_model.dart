import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }

  return null;
}

class UserInfoModel {
  UserInfoModel({
    this.coinCount,
    this.level,
    this.nickname,
    this.rank,
    this.userId,
    this.username,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> jsonRes) => UserInfoModel(
    coinCount: asT<int?>(jsonRes['coinCount']),
    level: asT<int?>(jsonRes['level']),
    nickname: asT<String?>(jsonRes['nickname']),
    rank: asT<String?>(jsonRes['rank']),
    userId: asT<int?>(jsonRes['userId']),
    username: asT<String?>(jsonRes['username']),
  );

  int? coinCount;
  int? level;
  String? nickname;
  String? rank;
  int? userId;
  String? username;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'coinCount': coinCount,
    'level': level,
    'nickname': nickname,
    'rank': rank,
    'userId': userId,
    'username': username,
  };
  @override
  String toString() {
    return jsonEncode(this);
  }
}
