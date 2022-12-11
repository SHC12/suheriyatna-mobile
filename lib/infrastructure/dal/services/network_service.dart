import 'package:dio/dio.dart';

import 'url_list_service.dart';

class NetworkService {
  final Dio _client = Dio(
    BaseOptions(
      receiveTimeout: 10000, // 10 seconds
      sendTimeout: 10000,
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  /// Performs a GET request with [queryParameters]
  Future<Object?> get<T>(
      {required String path,
      required T Function(dynamic data) onSuccess,
      required T Function(dynamic error) onError,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      bool isRawResult = false,
      bool isResultCode = false}) async {
    try {
      _client.interceptors.add(LogInterceptor());
      final response = await _client.get(
        path,
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParameters,
      );

      return isRawResult ? onSuccess(response.data) : onSuccess(response.data);
    } on DioError catch (e) {
      return isResultCode ? onError(e.response?.statusCode) : onError(e.response?.data);
    } catch (e) {
      print(e.toString());
      return onError(e);
    }
  }

  /// Performs a POST request with [body], then executes the functions
  /// with generic return value
  Future<Object?> postLogin<T>({
    required String path,
    required T Function(dynamic content) onSuccess,
    required T Function(dynamic error) onError,
    required Map<String, dynamic> body,
    Map<String, dynamic>? headers,
    bool containsFile = false,
    bool isRawResult = false,
    bool isResultCode = false,
  }) async {
    try {
      try {
        _client.interceptors.add(LogInterceptor());

        final response = await _client.post(
          path,
          data: body,
          options: Options(
            headers: headers,
            contentType: Headers.jsonContentType,
          ),
        );

        return isRawResult ? onSuccess(response.data) : onSuccess(response.data);
      } on DioError catch (e) {
        return isResultCode ? onError(e.response?.statusCode) : onError(e.response?.data);
      } catch (e) {
        print(e.toString());
        return onError(e);
      }
    } catch (error) {
      print('Error $error');
      // return Get.offAll(ErrorPage(tipe: 'not_secure'));
      return onError(error);
    }
  }

  Future<Object?> post<T>({
    required String path,
    required T Function(dynamic content) onSuccess,
    required T Function(dynamic error) onError,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool containsFile = false,
    bool isRawResult = false,
    bool isResultCode = false,
  }) async {
    try {
      print('header : $headers');
      try {
        _client.interceptors.add(LogInterceptor());

        final response = await _client.post(
          path,
          data: containsFile ? FormData.fromMap(body!) : body,
          options: Options(
            headers: headers,
            contentType: Headers.jsonContentType,
          ),
        );

        return isRawResult ? onSuccess(response.data) : onSuccess(response.data);
      } on DioError catch (e) {
        print(e.response?.data);
        return isResultCode ? onError(e.response?.statusCode) : onError(e.response?.data);
      } catch (e) {
        print(e.toString());
        return onError(e);
      }
    } catch (error) {
      print('Error $error');
      return onError(error);
    }
  }

  /// Performs a PUT request with [body], then executes the functions
  /// with generic return value
  ///
  /// if the request contains a file, set [containsFile] to true
  Future<T> put<T>({
    required String path,
    required T Function(dynamic content) onSuccess,
    required T Function(dynamic error) onError,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool containsFile = false,
    bool isRawResult = false,
  }) async {
    try {
      final response = await _client.put(
        path,
        data: containsFile ? FormData.fromMap(body!) : body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return isRawResult ? onSuccess(response.data) : onSuccess(response.data);
    } on DioError catch (e) {
      return onError(e.response?.data);
    } catch (e) {
      print(e.toString());
      return onError(e);
    }
  }

  Future<Object?> delete<T>({
    required String path,
    required T Function(dynamic content) onSuccess,
    required T Function(dynamic error) onError,
    Map<String, dynamic>? headers,
    bool isRawResult = false,
    bool containsFile = false,
    bool isResultCode = false,
  }) async {
    try {
      try {
        _client.interceptors.add(LogInterceptor());
        final response = await _client.delete(
          path,
          options: Options(headers: headers),
        );
        return isRawResult ? onSuccess(response.data) : onSuccess(response.data);
      } on DioError catch (e) {
        print(e.response!.data);
        return isResultCode ? onError(e.response?.statusCode) : onError(e.response?.data);
      } catch (e) {
        // print(e.toString());
        return onError(e);
      }
      // }
    } catch (error) {
      print('Error $error');
      // return Get.offAll(ErrorPage(tipe: 'not_secure'));
      return onError(error);
    }
  }
}
