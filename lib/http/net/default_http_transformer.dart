import 'package:get/get.dart' as getx;
import 'package:wan_android_getx/bean/response_data_model.dart';
import 'package:wan_android_getx/utils/extension/extension.dart';
import 'package:wan_android_getx/utils/extension/get_extension.dart';
import 'package:wan_android_getx/utils/log_util.dart';

import 'dio_new.dart';

class DefaultHttpTransformer extends HttpTransformer {
  @override
  HttpResponse parse(Response response) {
    var res = ResponseData.fromJson(response.data);

    if (res.errorCode == 0) {
      return HttpResponse.success(res.data);
    } else {
      Log.e("${res.errorMsg}---${res.errorCode}");
      return HttpResponse.failure(
          errorMsg: res.errorMsg, errorCode: res.errorCode);
    }
  }

  /// 单例对象
  static DefaultHttpTransformer _instance = DefaultHttpTransformer._internal();

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  DefaultHttpTransformer._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory DefaultHttpTransformer.getInstance() => _instance;
}
