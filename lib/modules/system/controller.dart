import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/api/system_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/system_tree_entity.dart';
import 'package:wan_android_getx/const/constants.dart';

class SystemController extends BaseGetXController {
  var _api = Get.find<SystemApi>();

  var _treeList = <SystemTreeEntity>[].obs;

  var _openList = <bool>[].obs;

  List<GlobalKey> iconKeys = <GlobalKey>[].obs;

  List<SystemTreeEntity> get getTreeList => _treeList;

  List<bool> get getOpenList => _openList;


  changePosition(bool isOpen, int key) {
    _openList[key]=isOpen;
  }

  requestSystem(bool isLoading) {
    List<SystemTreeEntity> list = [];
    _openList.clear();

    handlerStateRequest(
      _api.getSystemTree,
      (value) {
        value.forEach((e) {
          list.add(SystemTreeEntity().fromJson(e));
        });
        _treeList.value = list;
        _treeList.forEach((element) {
          _openList.add(false);
        });
        loadState.value = list.isNotEmpty ? LoadState.SUCCESS : LoadState.EMPTY;
      },
      isLoading: isLoading,
    );
  }

  @override
  initData() {
    requestSystem(true);
  }
}
