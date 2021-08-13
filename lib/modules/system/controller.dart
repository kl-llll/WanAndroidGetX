import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/api/system_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/bean/system_tree_entity.dart';
import 'package:wan_android_getx/const/constants.dart';

class SystemController extends BaseGetXController {
  var _api = Get.find<SystemApi>();

  var _treeList = <SystemTreeEntity>[].obs;

  var isExpansion = false.obs;

  List<GlobalKey> iconKeys = <GlobalKey>[].obs;

  List<SystemTreeEntity> get getTreeList => _treeList;

  var end = 1.0.obs;
  var key = 999.obs;

  changePosition(bool isOpen, int iconKey) {
    key.value = iconKey;
    end.value = isOpen ? 1 : 15;
  }

  requestSystem(bool isLoading) {
    List<SystemTreeEntity> list = [];

    handlerStateRequest(
      _api.getSystemTree,
      (value) {
        value.forEach((e) {
          list.add(SystemTreeEntity().fromJson(e));
        });
        _treeList.value = list;
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
