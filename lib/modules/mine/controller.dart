import 'dart:convert';

import 'package:get/get.dart';
import 'package:wan_android_getx/api/mine_api.dart';
import 'package:wan_android_getx/app/base/base_getx_controller.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:xml2json/xml2json.dart';

class MineController extends BaseGetXController {
  var _api = Get.find<MineApi>();

  var _imageSrc = "".obs;

  String get getImageSrc => _imageSrc.value;



  getBingImg() async {
    var response = await _api.getBingImage();
    final myTransformer = Xml2Json();
    myTransformer.parse(response.data);
    var jsonForBing = jsonDecode(myTransformer.toParker());
    _imageSrc.value = "https://www.bing.com${jsonForBing["images"]["image"][0]["url"]}";
  }

  @override
  void onInit() {
    super.onInit();
    getBingImg();
  }
}
