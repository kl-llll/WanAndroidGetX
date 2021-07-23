import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/mine_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/index.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/widget/load_sir.dart';

class CollectController extends BaseGetXController {
  var _api = Get.find<MineApi>();

  var pageIndex = 0;

  var _collectList = <HomeArticleDatas>[].obs;

  List<HomeArticleDatas> get getCollectList => _collectList;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  _getCollectList(bool isLoading) {
    handlerStateRequest(
        _api.getCollectList(pageIndex),
        (value) {
          HomeArticleEntity data = HomeArticleEntity().fromJson(value);
          var curPage = data.curPage;
          var pageCount = data.pageCount;

          if (curPage == 1 && data.datas!.isEmpty) {
            loadState.value = LoadState.EMPTY;
          } else if (curPage == pageCount) {
            loadState.value = LoadState.SUCCESS;
            _collectList.addAll(data.datas!);

            refreshController.loadNoData();
          } else {
            loadState.value = LoadState.SUCCESS;
            _collectList.addAll(data.datas!);
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

  @override
  initData() async {
    await _getCollectList(true);
  }

  refresh() async {
    pageIndex = 0;
    await _getCollectList(false);
  }

  loadMore() {
    _getCollectList(false);
  }

  @override
  void onInit() {
    super.onInit();
    initData();
  }
}
