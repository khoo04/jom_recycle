import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final class Http {
  late final Dio _dio;
  static Http? _instance;
  factory Http() => _instance ??= Http._();

  Http._() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://us-central1-kitahack-jom-recycle.cloudfunctions.net",
      headers: {},
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    ));

    _dio.interceptors.add(PrettyDioLogger(
      enabled: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ));
  }

  static Dio get dio => Http()._dio;

  static Future<T> get<T>(
    String path, {
    Duration? delay,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _fetch(
      dio.get<T>(
        path,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  static Future<T> post<T>(
    String path, {
    Object? data,
    Duration? delay,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _fetch(
      dio.post<T>(
        path,
        data: data,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  static Future<T> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _fetch(
      dio.put<T>(
        path,
        data: data,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  static Future<T> delete<T>(
    String path, {
    Duration? delay,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _fetch(
      dio.delete<T>(
        path,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<T> _fetch<T>(Future<Response> future) {
    return future.then<T>((res) {
      return res.data;
    }).catchError((err) {
      throw err;
    });
  }
}
