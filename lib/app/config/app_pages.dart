import 'package:get/get.dart';
import 'package:ownsaemiro_admin/app/binding/root_binding.dart';
import 'package:ownsaemiro_admin/app/config/app_routes.dart';
import 'package:ownsaemiro_admin/presentation/view/root_screen.dart';

List<GetPage> appPages = [
  GetPage(
    name: Routes.ROOT,
    page: () => const RootScreen(),
    binding: RootBinding(),
  ),
];