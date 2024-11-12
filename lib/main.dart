import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_getx/connectivity_controller.dart';
import 'package:internet_connection_getx/home_page.dart';
import 'no_internet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //return our connectivity controller
  Get.put(ConnectivityController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Internet Connection GetX',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHome());
  }
}
