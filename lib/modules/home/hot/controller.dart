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

  int pageIndex = 0;


  void getHomeArticle()  {

      handleRequest(_api.getHomeArticle(pageIndex), (value) {
        HomeArticleModel data = HomeArticleModel.fromJson(value);
        int curPage = data.curPage;
        int pageCount = data.pageCount;

        if (curPage == 1) {
          _homeArticleList.clear();
        }

        if (curPage == 1 && data.datas!.isEmpty) {
          loadState.value = LoadState.EMPTY;
        } else if (curPage == pageCount) {
          refreshController.loadNoData();
        } else {
          loadState.value = LoadState.SUCCESS;
          _homeArticleList.addAll(data.datas!);
          refreshController.loadComplete();
        }

        refreshController.refreshCompleted();
      }, failure: (e) {
        refreshController.loadFailed();
        refreshController.refreshFailed();
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
