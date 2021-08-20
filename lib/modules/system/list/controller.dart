import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/system_api.dart';
import 'package:wan_android_getx/const/constants.dart';

class ListController extends BaseGetXController {
  var _api = Get.find<SystemApi>();

  int pageId = 0;

  var _cid = 0;

  var title = "".obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  var _systemList = <HomeArticleDatas>[].obs;

  List<HomeArticleDatas> get getSystemList => _systemList;

  @override
  void onInit() {
    super.onInit();
    var map = Get.arguments;
    _cid = map["cid"];
    title.value = map["title"];
    initData();
  }

  getQuestion(bool isLoading) async {
    await handlerStateRequest(
      _api.getSystemList(pageId, _cid),
      (value) {
        HomeArticleEntity data = HomeArticleEntity().fromJson(value);
        var curPage = data.curPage;
        var pageCount = data.pageCount;

        if (curPage == 1 && data.datas!.isEmpty) {
          loadState.value = LoadState.EMPTY;
        } else if (curPage == pageCount) {
          loadState.value = LoadState.SUCCESS;
          pageId == 0
              ? _systemList.value = data.datas!
              : _systemList.addAll(data.datas!);
          refreshController.loadNoData();
        } else {
          loadState.value = LoadState.SUCCESS;

          pageId == 0
              ? _systemList.value = data.datas!
              : _systemList.addAll(data.datas!);
          refreshController.loadComplete();
          pageId++;
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
    await getQuestion(true);
  }

  refresh() async {
    pageId = 0;
    await getQuestion(false);
  }

  loadMore() {
    getQuestion(false);
  }
}
