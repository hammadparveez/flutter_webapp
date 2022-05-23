
import 'package:flutter/material.dart';
import 'package:flutter_webapp/utils/colors.dart';
import 'package:get/get.dart';

class AgencyApp extends StatelessWidget {
  const AgencyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(color: AppColors.transparent),
          scaffoldBackgroundColor: AppColors.backgroundColor,
        ),
        home:
    );
  }
}
