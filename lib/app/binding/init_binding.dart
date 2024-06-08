import 'package:get/get.dart';
import 'package:ownsaemiro_admin/data/provider/ticket/ticket_provider.dart';
import 'package:ownsaemiro_admin/data/provider/ticket/ticket_provider_impl.dart';
import 'package:ownsaemiro_admin/data/repository/ticket/ticket_repository.dart';
import 'package:ownsaemiro_admin/data/repository/ticket/ticket_repository_impl.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // Provider
    Get.lazyPut<TicketProvider>(() => TicketProviderImpl());

    // Repository
    Get.lazyPut<TicketRepository>(() => TicketRepositoryImpl());
  }
}
