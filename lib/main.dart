import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ownsaemiro_admin/app/main_app.dart';

void main() async {
  await onSystemInit();
  runApp(const MainApp());
}

Future<void> onSystemInit() async {
  // WidgetsBinding
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  await dotenv.load(fileName: "assets/configs/.env");
}