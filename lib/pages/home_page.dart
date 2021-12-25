import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_boilerplate/controllers/home_page_controller.dart';
import 'package:flutter_getx_boilerplate/widgets/input/item_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // Instantiate Getx Controllers move to InitialBindings, this page just need to Get.find
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // body: Text('lol'),
      body: GetX<HomePageController>(builder: (ctrl) {
        return ListView.builder(
          itemCount: ctrl.todos.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ItemMenu(
                title: ctrl.todos[index]['title'],
                onPressed: () {
                  print(ctrl.todos[index]);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
