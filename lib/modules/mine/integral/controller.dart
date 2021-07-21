import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/mine_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/integral_list_entity.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/widget/load_sir.dart';

class IntegralController extends BaseGetXController {
  var _api = Get.find<MineApi>();

  var _integralList = <IntegralListDatas>[].obs;

  List<IntegralListDatas> get getIntegralList => _integralList;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int pageIndex = 1;

  _getIntegralList(bool isLoading) {
    handlerStateRequest(
        _api.getIntegralList(pageIndex),
        (value) {
          IntegralListEntity data = IntegralListEntity().fromJson(value);
          var curPage = data.curPage;
          var pageCount = data.pageCount;

          if (curPage == 1 && data.datas!.isEmpty) {
            loadState.value = LoadState.EMPTY;
          } else if (curPage == pageCount) {
            loadState.value = LoadState.SUCCESS;
            refreshController.loadNoData();
          } else {
            loadState.value = LoadState.SUCCESS;
            _integralList.addAll(data.datas!);
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
    await _getIntegralList(true);
  }

  refresh() async {
    pageIndex = 1;
    await _getIntegralList(false);
  }

  loadMore() {
    _getIntegralList(false);
  }

  @override
  void onInit() {
    super.onInit();
    initData();
  }
}
