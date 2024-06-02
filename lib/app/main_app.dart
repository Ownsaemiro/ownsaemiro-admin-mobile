import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:ownsaemiro_admin/app/binding/init_binding.dart';
import 'package:ownsaemiro_admin/app/config/app_pages.dart';
import 'package:ownsaemiro_admin/app/config/app_routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return GetMaterialApp(
      title: "Ownsaemiro Admin",
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('ko', 'KR'),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        colorSchemeSeed: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: Routes.ROOT,
      initialBinding: InitBinding(),
      getPages: appPages,
    );
  }
}