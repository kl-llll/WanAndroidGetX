import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/search_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/home_article_entity.dart';
import 'package:wan_android_getx/const/constants.dart';

class SearchController extends BaseGetXController {
  var _api = Get.find<SearchApi>();

  int pageId = 0;

  var hotKey = <String>[].obs;
  var searchKey = "".obs;

  var _searchList = <HomeArticleDatas>[].obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<HomeArticleDatas> get getSearchList => _searchList;

  getSearch(bool isLoading) async {
    if (isLoading) pageId = 0;

    await handlerStateRequest(
      _api.searchKey(pageId, searchKey.value),
      (value) {
        HomeArticleEntity data = HomeArticleEntity().fromJson(value);
        var curPage = data.curPage;
        var pageCount = data.pageCount;

        if (curPage == 1 && data.datas!.isEmpty) {
          loadState.value = LoadState.EMPTY;
        } else if (curPage == pageCount) {
          loadState.value = LoadState.SUCCESS;
          pageId == 0
              ? _searchList.value = data.datas!
              : _searchList.addAll(data.datas!);
          refreshController.loadNoData();
        } else {
          loadState.value = LoadState.SUCCESS;

          pageId == 0
              ? _searchList.value = data.datas!
              : _searchList.addAll(data.datas!);
          refreshController.loadComplete();

          pageId++;
        }
      },
      isLoading: isLoading,
      failure: (e) {
        refreshController.loadFailed();
        refreshController.refreshFailed();
      },
    );
  }

  refresh() async {
    pageId = 0;
    await getSearch(false);
  }

  loadMore() {
    getSearch(false);
  }

  @override
  void onInit() {
    super.onInit();
    loadState.value = LoadState.DONE;

    handlerRequest(
      _api.getHotKey,
      (value) {
        value.forEach((e) {
          hotKey.add(e["name"]);
        });
      },
    );
  }
}
