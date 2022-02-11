import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';

import '../dio_new.dart';
import 'app_dio.dart';
import 'http_parse.dart';

class HttpClient {
  late AppDio _dio;

  HttpClient({BaseOptions? options, HttpConfig? dioConfig})
      : _dio = AppDio(options: options, dioConfig: dioConfig);

  Future<HttpResponse> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    HttpTransformer? httpTransformer,
    bool isShowEasyLoading = true,
  }) async {
    try {
      if (isShowEasyLoading) EasyLoading.show(dismissOnTap: true);

      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (isShowEasyLoading) await EasyLoading.dismiss();
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    HttpTransformer? httpTransformer,
    bool isShowEasyLoading = true,
  }) async {
    try {
      if (isShowEasyLoading) EasyLoading.show(dismissOnTap: true);

      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (isShowEasyLoading) await EasyLoading.dismiss();
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isShowEasyLoading = true,
    HttpTransformer? httpTransformer,
  }) async {
    try {
      if (isShowEasyLoading) EasyLoading.show(dismissOnTap: true);
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (isShowEasyLoading) await EasyLoading.dismiss();
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> delete(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      bool isShowEasyLoading = true,
      HttpTransformer? httpTransformer}) async {
    try {
      if (isShowEasyLoading) EasyLoading.show(dismissOnTap: true);
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (isShowEasyLoading) await EasyLoading.dismiss();
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<HttpResponse> put(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      bool isShowEasyLoading = true,
      HttpTransformer? httpTransformer}) async {
    try {
      if (isShowEasyLoading) EasyLoading.show(dismissOnTap: true);
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (isShowEasyLoading) await EasyLoading.dismiss();
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }

  Future<Response> download(String urlPath, savePath,
      {ProgressCallback? onReceiveProgress,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      bool deleteOnError = true,
      bool isShowEasyLoading = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options? options,
      HttpTransformer? httpTransformer}) async {
    try {
      if (isShowEasyLoading) EasyLoading.show(dismissOnTap: true);
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
      if (isShowEasyLoading) await EasyLoading.dismiss();
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<HttpResponse> upload(
    String uri, {
    data,
    required String filePath,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    HttpTransformer? httpTransformer,
    bool isShowEasyLoading = true,
  }) async {
    try {
      if (isShowEasyLoading) EasyLoading.show(dismissOnTap: true);

      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

      Map<String, dynamic> fileMap = {
        "file": await MultipartFile.fromFile(
          filePath,
          filename: timeStamp,
        ),
      };

      fileMap.addAll(data);
      FormData formData = FormData.fromMap(fileMap);

      var response = await _dio.post(
        uri,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (isShowEasyLoading) await EasyLoading.dismiss();
      return handleResponse(response, httpTransformer: httpTransformer);
    } on Exception catch (e) {
      return handleException(e);
    }
  }
}
