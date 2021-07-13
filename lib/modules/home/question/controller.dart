import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/question_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/home_article_entity.dart';
import 'package:wan_android_getx/widget/load_sir.dart';

class QuestionController extends BaseGetXController {
  var _api = Get.find<QuestionApi>();

  int pageId = 0;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  var _squareList = <HomeArticleDatas>[].obs;

  List<HomeArticleDatas> get getSquareList => _squareList;

  getQuestion(bool isLoading) async {
    await handlerStateRequest(
      _api.getQuestionList(pageId),
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

          pageId == 0
              ? _squareList.value = data.datas!
              : _squareList.addAll(data.datas!);
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

  @override
  void onInit() {
    super.onInit();
    initData();
  }
}
