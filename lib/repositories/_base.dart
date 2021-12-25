import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/utils/constants/http.dart';

class BaseRepository {
  final Dio? _dio;

  BaseRepository(this._dio);

  @protected
  Future<dynamic> requestApi({
    required String method,
    required String url,
    String? idToken = '',
    Map<String, dynamic>? queryParam,
    Options? options,
    dynamic data,
  }) async {
    dynamic response = false;

    try {
      response = await _sendRequest(
        method: method,
        url: url,
        idToken: idToken!,
        queryParam: queryParam,
        options: options,
        data: data,
      );

      return response;
    } catch (e) {
      debugPrint('Error from base repository $e');
      return response;
    }
  }

  Future<dynamic> _sendRequest({
    required String method,
    required String url,
    String? idToken,
    Map<String, dynamic>? queryParam,
    Options? options,
    dynamic data,
  }) async {
    try {
      Future<Response<dynamic>> apiReturn;

      options ??= Options(headers: {});

      if (idToken != null) {
        if (idToken.trim().isNotEmpty) options.headers!['Authorization'] = 'Bearer $idToken';
      }

      if (method == GET) {
        apiReturn = _dio!.get(url, queryParameters: queryParam, options: options);
      } else if (method == POST) {
        apiReturn = _dio!.post(url, queryParameters: queryParam, options: options, data: data);
      } else if (method == PUT) {
        apiReturn = _dio!.put(url, queryParameters: queryParam, options: options, data: data);
      } else {
        apiReturn = _dio!.delete(url, queryParameters: queryParam, options: options, data: data);
      }

      return await apiReturn.then((resp) {
        // error status code
        return resp.data;
      });
    } on DioError catch (ex) {
      Map<String, dynamic> _data = {
        'status': HTTP_INTERNAL_SERVER_ERROR,
        'success': false,
      };
      debugPrint('Error on request to $url');
      if (ex.type == DioErrorType.connectTimeout) {
        debugPrint('Error Connection Timeout Exception ${ex.message}');
        // throw Exception("Connection  Timeout Exception");
      } else {
        debugPrint('Error Exception ${ex.message}');
        if (ex.response != null) {
          if (ex.response!.data is Map) {
            debugPrint('Error Exception response data ${ex.response!.data}');
            _data = ex.response!.data;
          }
        } else {
          debugPrint('Error $ex');
          debugPrint('Error Message ${ex.message}');
        }
        // throw Exception(ex.message);
      }
      return {data: _data};
    }
  }
}
