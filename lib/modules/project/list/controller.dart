import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/project_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/project_list_entity.dart';
import 'package:wan_android_getx/widget/load_sir.dart';

class ListController extends BaseGetXController {
  var _api = Get.find<ProjectApi>();

  var _projectList = <ProjectListDatas>[].obs;

  List<ProjectListDatas> get getProjectList => _projectList;

  late RefreshController refreshController;

  var pageIndex = 0;

  var cId = 0;

  requestProjectList(bool isLoading, int cId) => handlerStateRequest(
        _api.getProjectList(pageIndex, cId),
        (value) {
          ProjectListEntity data = ProjectListEntity().fromJson(value);
          var curPage = data.curPage;
          var pageCount = data.pageCount;

          if (curPage == 1 && data.datas!.isEmpty) {
            loadState.value = LoadState.EMPTY;
          } else if (curPage != 1 && curPage == pageCount) {
            loadState.value = LoadState.SUCCESS;
            pageIndex == 0
                ? _projectList.value = data.datas!
                : _projectList.addAll(data.datas!);
            refreshController.loadNoData();
          } else {
            loadState.value = LoadState.SUCCESS;
            pageIndex == 0
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
  initData() {
    requestProjectList(true, cId);
  }

  @override
  refresh() {
    requestProjectList(false, cId);
  }



  @override
  void onInit() {
    super.onInit();
    initData();
    refreshController = new RefreshController(initialRefresh: false);
  }
}
