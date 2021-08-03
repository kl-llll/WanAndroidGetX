import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/collect_api.dart';
import 'package:wan_android_getx/api/project_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/project_list_entity.dart';
import 'package:wan_android_getx/widget/load_sir.dart';
import 'package:wan_android_getx/const/constants.dart';

class ListController extends BaseGetXController {
  final int cId;

  ListController(this.cId);

  var _api = Get.find<ProjectApi>();
  var _collectApi = Get.find<CollectApi>();

  var _projectList = <ProjectListDatas>[].obs;

  List<ProjectListDatas> get getProjectList => _projectList;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  var pageIndex = 1;

  requestProjectList(bool isLoading) => handlerStateRequest(
        _api.getProjectList(pageIndex, cId),
        (value) {
          ProjectListEntity data = ProjectListEntity().fromJson(value);
          var curPage = data.curPage;
          var pageCount = data.pageCount;

          if (curPage == 1 && data.datas!.isEmpty) {
            loadState.value = LoadState.EMPTY;
          } else if (curPage != 1 && curPage == pageCount) {
            loadState.value = LoadState.SUCCESS;
            pageIndex == 1
                ? _projectList.value = data.datas!
                : _projectList.addAll(data.datas!);
            refreshController.loadNoData();
          } else {
            loadState.value = LoadState.SUCCESS;
            pageIndex == 1
                ? _projectList.value = data.datas!
                : _projectList.addAll(data.datas!);
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

  @override
  collect(int id) async {
    bool isSuccess = false;
    await handlerRequest(_collectApi.collect(id), (value) {
      isSuccess = true;
      Get.showCustomSnackbar("收藏成功!");
    });
    return isSuccess;
  }

  @override
  unCollect(int id, int? originId) async {
    bool isSuccess = false;
    await handlerRequest(_collectApi.unCollect(id), (value) {
      isSuccess = true;
      Get.showCustomSnackbar("取消收藏成功!");
    });
    return isSuccess;
  }

  @override
  initData() {
    requestProjectList(true);
  }

  @override
  refresh() {
    pageIndex = 1;
    requestProjectList(false);
  }

  @override
  loadMore() {
    requestProjectList(false);
  }

  @override
  void onInit() {
    super.onInit();
    initData();
  }
}
