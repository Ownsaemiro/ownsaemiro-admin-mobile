import 'package:get/get.dart';
import 'package:ownsaemiro_admin/presentation/view_model/root_view_model.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootViewModel>(() => RootViewModel());
  }
}