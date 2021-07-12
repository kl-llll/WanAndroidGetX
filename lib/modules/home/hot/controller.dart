import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/hot_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/banner_data_entity.dart';
import 'package:wan_android_getx/bean/home_article_entity.dart';
import 'package:wan_android_getx/const/constants.dart';

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
    await handlerStateRequest(
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

    await handlerRequest(_api.getTopArticle, (value) {
      value.forEach((e) {
        list.add(HomeArticleDatas().fromJson(e));
      });
      _homeArticleList.value = list;
    });
  }

  get getBanner async {
    List<BannerDataEntity> list = [];

    await handlerRequest(_api.getBanner, (value) {
      value.forEach((e) {
        list.add(BannerDataEntity().fromJson(e));
      });
      _bannerList.value = list;
    });
  }

  collect(int id) async {
    bool isSuccess = false;
    await handlerRequest(_api.collect(id), (value) {
      isSuccess = true;
      Get.showCustomSnackbar("收藏成功!");
    });
    return isSuccess;
  }

  unCollect(int id) async {
    bool isSuccess = false;
    await handlerRequest(_api.unCollect(id), (value) {
      isSuccess = true;
      Get.showCustomSnackbar("取消收藏成功!");
    });
    return isSuccess;
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
