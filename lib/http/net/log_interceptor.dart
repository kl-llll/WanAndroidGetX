
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

///日志拦截器
class DioLogInterceptor extends Interceptor {
  bool isDebug = true;


  var _logger = Logger(
    printer: PrettyPrinter(
      methodCount:0,
        lineLength: 100,
    ),
  );

  @override
  Future onRequest( RequestOptions options, RequestInterceptorHandler handler) async {
    if (isDebug) {
      String requestStr = "\n╔═════════════════════════ REQUEST ═════════════════════════╗\n"
          "- URL:\n${options.baseUrl + options.path}\n"
          "- METHOD: ${options.method}\n";

      requestStr += "- HEADER:${options.headers}\n";
      if (options.queryParameters.isNotEmpty) {
        requestStr += "- QUERYPARAMETERS:\n${options.queryParameters}\n";
      }
      final data = options.data;
      if (data != null) {
        if (data is Map)
          requestStr += "- BODY:\n$data\n";
        else if (data is FormData) {
          final formDataMap = Map()..addEntries(data.fields)..addEntries(data.files);
          requestStr += "- BODY:\n$formDataMap\n";
        } else
          requestStr += "- BODY:\n$data.toString()\n";
      }

      requestStr += "\n╚═════════════════════════ REQUEST ═════════════════════════╝\n";
      _logger.d(requestStr);
    }

    handler.next(options);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (isDebug) {
      String errorStr = "\n╔═════════════════════════ RESPONSE ═════════════════════════╗\n"
          "- URL:${err.requestOptions.baseUrl + err.requestOptions.path}\n"
          "- METHOD: ${err.requestOptions.method}\n";

      // try {
      //   errorStr += "- HEADER:\n${err.response.headers.map.mapToStructureString()}\n";
      // } catch (e) {}

      if (err.response != null && err.response!.data != null) {
        _logger.e('╔ ${err.type.toString()}');
        errorStr += "- ERROR:\n${err.response}\n";

      } else {
        errorStr += "- ERRORTYPE: ${err.type}\n";
        errorStr += "- MSG: ${err.message}\n";
      }
      errorStr += "\n╚═════════════════════════ RESPONSE ═════════════════════════╝\n";

      _logger.e(errorStr);
    }
    handler.next(err);

  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (isDebug) {
      dynamic responseStr = "\n╔═════════════════════════ RESPONSE ═════════════════════════╗\n"
          "- URL:${response.requestOptions.uri}\n";
     // responseStr += "- HEADER:\n{";
     // response.headers.forEach(
     //     (key, list) => responseStr += "\n  " + "\"$key\" : \"$list\",");
     // responseStr += "\n}\n";
      responseStr += "- STATUS: ${response.statusCode}\n";

      if (response.data != null) {
        responseStr += " ${response.data}";

      }

      responseStr += "\n╚═════════════════════════ RESPONSE ═════════════════════════╝\n";

      _logger.d(responseStr);
    }
    handler.next(response);

  }

}


