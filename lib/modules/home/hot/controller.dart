import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/home_article_model.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/modules/home/api/hot_api.dart';

class HotController extends BaseGetXController {
  var _api = Get.find<HotApi>();

  List<HomeArticleDatas> get homeArticleList => _homeArticleList;

  var _homeArticleList = <HomeArticleDatas>[].obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void getHomeArticle() async {
    handleRequest(_api.getHomeArticle(0), true, (value) {

      HomeArticleModel homeArticleModel=HomeArticleModel.fromJson(value);


      if (homeArticleModel.datas!.isEmpty) {
        refreshController.refreshFailed();
        return;
      } else {
        _homeArticleList.value = homeArticleModel.datas!;
        refreshController.refreshCompleted();
      }
    });


  }

  void getData() {
    getHomeArticle();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
