import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_boilerplate/pages/home_page.dart';

List<GetPage> routes = [
  GetPage(
    name: '/home',
    page: () => HomePage(),
  ),
];

// note that you can create separated file for grouped route
List<GetPage> pages() {
  return routes;
}
