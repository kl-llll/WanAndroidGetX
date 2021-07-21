import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/mine_api.dart';
import 'package:wan_android_getx/bean/rank_list_entity.dart';
import 'package:wan_android_getx/const/constants.dart';

class RankController extends BaseGetXController {
  var _api = Get.find<MineApi>();

  var _rankList = <RankListDatas>[].obs;

  List<RankListDatas> get getRankList => _rankList;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  int pageIndex = 1;

  _getRankList(bool isLoading) {
    handlerStateRequest(
        _api.getRankList(pageIndex),
            (value) {
          RankListEntity data = RankListEntity().fromJson(value);
          var curPage = data.curPage;
          var pageCount = data.pageCount;

          if (curPage == 1 && data.datas!.isEmpty) {
            loadState.value = LoadState.EMPTY;
          } else if (curPage == pageCount) {
            loadState.value = LoadState.SUCCESS;
            refreshController.loadNoData();
          } else {
            loadState.value = LoadState.SUCCESS;
            _rankList.addAll(data.datas!);
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
  void initData() async {
    await _getRankList(true);
  }

  refresh() async {
    pageIndex = 1;
    await _getRankList(false);
  }

  loadMore() {
    _getRankList(false);
  }

  @override
  void onInit() {
    super.onInit();
    initData();
  }
}
