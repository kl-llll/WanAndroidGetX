import 'package:wan_android_getx/utils/log_util.dart';

import 'dio_new.dart';

/// Response 解析
abstract class HttpTransformer {
  HttpResponse parse(Response response);
}

class HttpClient {
  late AppDio _dio;

  HttpClient({BaseOptions? options, HttpConfig? dioConfig})
      : _dio = AppDio(options: options, dioConfig: dioConfig);

  Future get(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      HttpResponse appResponse =
          handleResponse(response, httpTransformer: httpTransformer);
      if (appResponse.ok) {
        return appResponse.data;
      } else {
        throw HttpException(appResponse.error!.msg, appResponse.error!.code);
      }
    } on Exception catch (e) {
      Log.e(e);
      HttpResponse httpResponse=handleException(e);
      throw HttpException(httpResponse.error!.msg, httpResponse.error!.code);
    }
  }

  Future<HttpResponse> post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      HttpResponse appResponse =
      handleResponse(response, httpTransformer: httpTransformer);
      if (appResponse.ok) {
        return appResponse.data;
      } else {
        throw HttpException(appResponse.error!.msg, appResponse.error!.code);
      }
    } on Exception catch (e) {
      Log.e(e);
      HttpResponse httpResponse=handleException(e);
      throw HttpException(httpResponse.error!.msg, httpResponse.error!.code);
    }
  }

  Future<HttpResponse> patch(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      HttpResponse appResponse =
      handleResponse(response, httpTransformer: httpTransformer);
      if (appResponse.ok) {
        return appResponse.data;
      } else {
        throw HttpException(appResponse.error!.msg, appResponse.error!.code);
      }
    } on Exception catch (e) {
      Log.e(e);
      HttpResponse httpResponse=handleException(e);
      throw HttpException(httpResponse.error!.msg, httpResponse.error!.code);
    }
  }

  Future<HttpResponse> delete(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      HttpResponse appResponse =
      handleResponse(response, httpTransformer: httpTransformer);
      if (appResponse.ok) {
        return appResponse.data;
      } else {
        throw HttpException(appResponse.error!.msg, appResponse.error!.code);
      }
    } on Exception catch (e) {
      Log.e(e);
      HttpResponse httpResponse=handleException(e);
      throw HttpException(httpResponse.error!.msg, httpResponse.error!.code);
    }
  }

  Future<HttpResponse> put(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      HttpResponse appResponse =
      handleResponse(response, httpTransformer: httpTransformer);
      if (appResponse.ok) {
        return appResponse.data;
      } else {
        throw HttpException(appResponse.error!.msg, appResponse.error!.code);
      }
    } on Exception catch (e) {
      Log.e(e);
      HttpResponse httpResponse=handleException(e);
      throw HttpException(httpResponse.error!.msg, httpResponse.error!.code);
    }
  }

  Future<Response> download(String urlPath, savePath,
      {ProgressCallback? onReceiveProgress,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options? options,
      HttpTransformer? httpTransformer}) async {
    try {
      var response = await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
