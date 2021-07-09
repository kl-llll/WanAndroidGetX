import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/banner_data_entity.dart';
import 'package:wan_android_getx/bean/home_article_entity.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/modules/home/api/hot_api.dart';

class HotController extends BaseGetXController {
  var _api = Get.find<HotApi>();

  var _homeArticleList = <HomeArticleDatas>[].obs;

  List<HomeArticleDatas> get getHomeArticleList => _homeArticleList;

  var _bannerList = <BannerDataEntity>[].obs;

  List<BannerDataEntity> get getBannerList => _bannerList;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int pageIndex = 0;

  getHomeArticle(bool isLoading) async {
    await handleRequest(
        _api.getHomeArticle(pageIndex),
        (value) {
          HomeArticleEntity data = HomeArticleEntity().fromJson(value);
          var curPage = data.curPage;
          var pageCount = data.pageCount;

          if (curPage == 1 && data.datas!.isEmpty) {
            loadState.value = LoadState.EMPTY;
          } else if (curPage == pageCount) {
            loadState.value = LoadState.SUCCESS;
            refreshController.loadNoData();
          } else {
            loadState.value = LoadState.SUCCESS;
            _homeArticleList.addAll(data.datas!);
            refreshController.loadComplete();
            pageIndex++;
          }
          refreshController.refreshCompleted();
        },
        isLoading: isLoading,
        failure: (e) {
          refreshController.loadFailed();
          refreshController.refreshFailed();
        });
  }

  get getTopArticle async {
    List<HomeArticleDatas> list = [];

    await handleRequest(_api.getTopArticle, (value) {
      value.forEach((e) {
        list.add(HomeArticleDatas().fromJson(e));
      });
      _homeArticleList.value = list;
    });
  }

  get getBanner async {
    List<BannerDataEntity> list = [];

    await handleRequest(_api.getBanner, (value) {
      value.forEach((e) {
        list.add(BannerDataEntity().fromJson(e));
      });
      _bannerList.value = list;
    });
  }

  initData() async {
    getBanner;
    await getTopArticle;
    await getHomeArticle(true);
  }

  refresh() async {
    pageIndex = 0;
    getBanner;
    await getTopArticle;
    await getHomeArticle(false);
  }

  loadMore() {
    getHomeArticle(false);
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
