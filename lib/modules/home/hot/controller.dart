import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/bean/home_article_model.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/modules/home/api/hot_api.dart';

class HotController extends GetxController {
  var _api = Get.find<HotApi>();

  List<HomeArticleDatas>? get homeArticleList => _homeArticleList;

  var _homeArticleList = <HomeArticleDatas>[].obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  void getHomeArticle() async {
    await Future.delayed(Duration(seconds: 2));
    try {
      HomeArticleModel homeArticleModel;
      homeArticleModel = await _api.getHomeArticle(0);
      Log.i(homeArticleModel);
      if (homeArticleModel.datas!.isEmpty) {
        refreshController.refreshFailed();
        return;
      } else {
        _homeArticleList.value = homeArticleModel.datas!;
        refreshController.refreshCompleted();
      }
    } on Exception catch (e) {}
  }

  void getData() {
    getHomeArticle();
  }
}
