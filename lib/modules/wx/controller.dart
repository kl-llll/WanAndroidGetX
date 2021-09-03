import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/api/wx_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/project_tree_entity.dart';
import 'package:wan_android_getx/const/constants.dart';

class WXController extends BaseGetXController {


  var _api = Get.find<WXApi>();

  var _treeList = <ProjectTreeEntity>[].obs;

  List<ProjectTreeEntity> get getTreeList => _treeList;


  late TabController tabController;


  requestProjectTree(TickerProvider vsync) {
    List<ProjectTreeEntity> list = [];

    handlerStateRequest(_api.getWXTree, (value) {
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
