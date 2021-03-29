import 'package:flutter/material.dart';
import 'package:food/app.dart';
import 'package:food/src/infrastructure/repositories/localfood.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB().initDatabase();
  runApp(MyApp());
}
