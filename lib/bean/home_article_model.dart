import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }

  return null;
}

class HomeArticleModel {
  HomeArticleModel({
    required this.curPage,
     this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  factory HomeArticleModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<HomeArticleDatas>? datas =
    jsonRes['datas'] is List ? <HomeArticleDatas>[] : null;
    if (datas != null) {
      for (final dynamic item in jsonRes['datas']!) {
        if (item != null) {
          datas
              .add(HomeArticleDatas.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return HomeArticleModel(
      curPage: asT<int>(jsonRes['curPage'])!,
      datas: datas,
      offset: asT<int>(jsonRes['offset'])!,
      over: asT<bool>(jsonRes['over'])!,
      pageCount: asT<int>(jsonRes['pageCount'])!,
      size: asT<int>(jsonRes['size'])!,
      total: asT<int>(jsonRes['total'])!,
    );
  }

  int curPage;
  List<HomeArticleDatas>? datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'curPage': curPage,
    'datas': datas,
    'offset': offset,
    'over': over,
    'pageCount': pageCount,
    'size': size,
    'total': total,
  };
  @override
  String toString() {
    return jsonEncode(this);
  }
}

class HomeArticleDatas {
  HomeArticleDatas({
    this.apkLink,
    this.audit,
    this.author,
    this.canEdit,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.descMd,
    this.envelopePic,
    this.fresh,
    this.host,
    this.id,
    this.link,
    this.niceDate,
    this.niceShareDate,
    this.origin,
    this.prefix,
    this.projectLink,
    this.publishTime,
    this.realSuperChapterId,
    this.selfVisible,
    this.shareDate,
    this.shareUser,
    this.superChapterId,
    this.superChapterName,
    this.tags,
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan,
  });

  factory HomeArticleDatas.fromJson(Map<String, dynamic> jsonRes) {
    final List<Object>? tags = jsonRes['tags'] is List ? <Object>[] : null;
    if (tags != null) {
      for (final dynamic item in jsonRes['tags']!) {
        if (item != null) {
          tags.add(asT<Object>(item)!);
        }
      }
    }
    return HomeArticleDatas(
      apkLink: asT<String?>(jsonRes['apkLink']),
      audit: asT<int?>(jsonRes['audit']),
      author: asT<String?>(jsonRes['author']),
      canEdit: asT<bool?>(jsonRes['canEdit']),
      chapterId: asT<int?>(jsonRes['chapterId']),
      chapterName: asT<String?>(jsonRes['chapterName']),
      collect: asT<bool?>(jsonRes['collect']),
      courseId: asT<int?>(jsonRes['courseId']),
      desc: asT<String?>(jsonRes['desc']),
      descMd: asT<String?>(jsonRes['descMd']),
      envelopePic: asT<String?>(jsonRes['envelopePic']),
      fresh: asT<bool?>(jsonRes['fresh']),
      host: asT<String?>(jsonRes['host']),
      id: asT<int?>(jsonRes['id']),
      link: asT<String?>(jsonRes['link']),
      niceDate: asT<String?>(jsonRes['niceDate']),
      niceShareDate: asT<String?>(jsonRes['niceShareDate']),
      origin: asT<String?>(jsonRes['origin']),
      prefix: asT<String?>(jsonRes['prefix']),
      projectLink: asT<String?>(jsonRes['projectLink']),
      publishTime: asT<int?>(jsonRes['publishTime']),
      realSuperChapterId: asT<int?>(jsonRes['realSuperChapterId']),
      selfVisible: asT<int?>(jsonRes['selfVisible']),
      shareDate: asT<int?>(jsonRes['shareDate']),
      shareUser: asT<String?>(jsonRes['shareUser']),
      superChapterId: asT<int?>(jsonRes['superChapterId']),
      superChapterName: asT<String?>(jsonRes['superChapterName']),
      tags: tags,
      title: asT<String?>(jsonRes['title']),
      type: asT<int?>(jsonRes['type']),
      userId: asT<int?>(jsonRes['userId']),
      visible: asT<int?>(jsonRes['visible']),
      zan: asT<int?>(jsonRes['zan']),
    );
  }

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
  List<Object>? tags;
  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'apkLink': apkLink,
    'audit': audit,
    'author': author,
    'canEdit': canEdit,
    'chapterId': chapterId,
    'chapterName': chapterName,
    'collect': collect,
    'courseId': courseId,
    'desc': desc,
    'descMd': descMd,
    'envelopePic': envelopePic,
    'fresh': fresh,
    'host': host,
    'id': id,
    'link': link,
    'niceDate': niceDate,
    'niceShareDate': niceShareDate,
    'origin': origin,
    'prefix': prefix,
    'projectLink': projectLink,
    'publishTime': publishTime,
    'realSuperChapterId': realSuperChapterId,
    'selfVisible': selfVisible,
    'shareDate': shareDate,
    'shareUser': shareUser,
    'superChapterId': superChapterId,
    'superChapterName': superChapterName,
    'tags': tags,
    'title': title,
    'type': type,
    'userId': userId,
    'visible': visible,
    'zan': zan,
  };
  @override
  String toString() {
    return jsonEncode(this);
  }
}
