import 'dart:convert';

import 'package:get/get.dart';
import 'package:wan_android_getx/api/mine_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:xml2json/xml2json.dart';

class MineController extends BaseGetXController {
  var _api = Get.find<MineApi>();


  var index = -1;
  var _imageSrc = "".obs;

  String get getImageSrc => _imageSrc.value;

  var _integralEntity = IntegralEntity().obs;

  IntegralEntity get integralEntity => _integralEntity.value;

  getBingImg({bool isReset = false}) async {
    isReset ? index = 0 : index++;
    //只能查看一周内的壁纸
    if (index < 7) {
      var response = await _api.getBingImage(index);
      final myTransformer = Xml2Json();
      myTransformer.parse(response.data);
      var jsonForBing = jsonDecode(myTransformer.toParker());
      _imageSrc.value =
          "https://www.bing.com${jsonForBing["images"]["image"][0]["url"]}";
    }
  }

  get getIntegral async => await handlerRequest(_api.getIntegral, (value) {
        _integralEntity.value = IntegralEntity().fromJson(value);
      });

  @override
  void onInit() {
    super.onInit();
    ever(getIsLogin, (call){

      Log.i(call);
    });

  }

  @override
  void initData() {
    getBingImg();
    // getIntegral;
  }
}
