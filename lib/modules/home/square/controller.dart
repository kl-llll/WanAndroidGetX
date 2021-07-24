import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/square_api.dart';
import 'package:wan_android_getx/bean/home_article_entity.dart';
import 'package:wan_android_getx/const/constants.dart';

class SquareController extends BaseGetXController {
  var _api = Get.find<SquareApi>();

  int pageIndex = 0;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  var _squareList = <HomeArticleDatas>[].obs;

  List<HomeArticleDatas> get getSquareList => _squareList;

  getSquare(bool isLoading) async {
    await handlerStateRequest(
      _api.getSquareList(pageIndex),
      (value) {
        HomeArticleEntity data = HomeArticleEntity().fromJson(value);
        var curPage = data.curPage;
        var pageCount = data.pageCount;

        if (curPage == 1 && data.datas!.isEmpty) {
          loadState.value = LoadState.EMPTY;
        } else if (curPage == pageCount) {
          loadState.value = LoadState.SUCCESS;
          pageIndex == 0
              ? _squareList.value = data.datas!
              : _squareList.addAll(data.datas!);          refreshController.loadNoData();
        } else {
          loadState.value = LoadState.SUCCESS;

          pageIndex == 0
              ? _squareList.value = data.datas!
              : _squareList.addAll(data.datas!);
          refreshController.loadComplete();
          pageIndex++;
        }
        refreshController.refreshCompleted();
      },
      isLoading: isLoading,
      failure: (e) {
        refreshController.loadFailed();
        refreshController.refreshFailed();
      },
    );
  }

  @override
  initData() async {
    await getSquare(true);
  }

  refresh() async {
    pageIndex = 0;
    await getSquare(false);
  }

  loadMore() {
    getSquare(false);
  }

  @override
  void onInit() {
    super.onInit();
    initData();
  }
}
