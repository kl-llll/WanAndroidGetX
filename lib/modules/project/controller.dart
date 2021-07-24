import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wan_android_getx/api/project_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/project_list_entity.dart';
import 'package:wan_android_getx/bean/project_tree_entity.dart';
import 'package:wan_android_getx/widget/load_sir.dart';

class ProjectController extends BaseGetXController {
  var _api = Get.find<ProjectApi>();

  var _treeList = <ProjectTreeEntity>[].obs;

  List<ProjectTreeEntity> get getTreeList => _treeList;

  var _projectList = <ProjectListDatas>[].obs;

  List<ProjectListDatas> get getProjectList => _projectList;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  get requestProjectTree {
    List<ProjectTreeEntity> list = [];

    handlerStateRequest(_api.getProjectTree, (value) {
      value.forEach((e) {
        list.add(ProjectTreeEntity().fromJson(e));
      });
      loadState.value=LoadState.SUCCESS;
      _treeList.value = list;
    });
  }

  requestProjectList(bool isLoading, int pageIndex, int cId) =>
      handlerStateRequest(
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
  void initData() {
    requestProjectTree;
  }

  @override
  void onInit() {
    super.onInit();
    initData();
  }
}
