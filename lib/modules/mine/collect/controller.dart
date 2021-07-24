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

  _getCollectList(bool isLoading) =>
    handlerStateRequest(
        _api.getCollectList(pageIndex),
        (value) {
          HomeArticleEntity data = HomeArticleEntity().fromJson(value);
          var curPage = data.curPage;
          var pageCount = data.pageCount;

          if (curPage == 1 && data.datas!.isEmpty) {
            loadState.value = LoadState.EMPTY;
          } else if (curPage!=1&&curPage == pageCount) {
            loadState.value = LoadState.SUCCESS;
            pageIndex == 0
                ? _collectList.value = data.datas!
                : _collectList.addAll(data.datas!);
            refreshController.loadNoData();
          } else {
            loadState.value = LoadState.SUCCESS;
            pageIndex == 0
                ? _collectList.value = data.datas!
                : _collectList.addAll(data.datas!);
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


  @override
  unCollect(int id, int? originId) async {
    bool isSuccess = false;
    await handlerRequest(_api.unCollect(id, originId), (value) {
      isSuccess = true;
      Get.showCustomSnackbar("取消收藏成功!");
      refresh();
    });
    return isSuccess;
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
