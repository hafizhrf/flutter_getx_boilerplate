import 'package:get/get.dart';
import 'package:flutter_getx_boilerplate/repositories/mock_repository.dart';

class HomePageController extends GetxController {
  final MockRepository _mockRepository = Get.put(MockRepository(Get.find()));
  RxList todos = [].obs;

  @override
  void onInit() {
    _getTodos();
    super.onInit();
  }

  void _getTodos() async {
    List? resp = await _mockRepository.getTodos();
    if (resp != null) {
      todos(resp);
    }
  }
}
