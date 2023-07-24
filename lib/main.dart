// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:skin_detection/shard_screen.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();

  bool? isDark = CachHelper.getData(
    key: 'isDark',
  );
  runApp(MyApp(isDark));
}
