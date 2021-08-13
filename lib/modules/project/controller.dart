import 'package:flutter/material.dart';
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


  late TabController tabController;


  requestProjectTree(TickerProvider vsync) {
    List<ProjectTreeEntity> list = [];

    handlerStateRequest(_api.getProjectTree, (value) {
      value.forEach((e) {
        list.add(ProjectTreeEntity().fromJson(e));
      });
      _treeList.value = list;
      loadState.value = list.isNotEmpty ? LoadState.SUCCESS : LoadState.EMPTY;
      initController(list.length, vsync);
    });
  }



  initController(int length, TickerProvider vsync) {
    tabController = TabController(length: length, vsync: vsync);
  }

}
