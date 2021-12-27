import 'package:dio/dio.dart';
import 'package:flutter_getx_boilerplate/repositories/_base.dart';
import 'package:flutter_getx_boilerplate/utils/constants/http.dart';
import 'package:flutter_getx_boilerplate/utils/services/configs/constants.dart';

class MockRepository extends BaseRepository {
  MockRepository(Dio dio) : super(dio);

  Future<List>? getTodos() {
    return requestApi(
      method: GET,
      url: '$baseUrl/todos',
    ).then((response) {
      return response.data;
    });
  }
}
