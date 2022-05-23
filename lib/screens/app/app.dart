import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webapp/screens/agency/agency_screen.dart';
import 'package:flutter_webapp/utils/colors.dart';
import 'package:get/get.dart';

class AgencyApp extends StatelessWidget {
  const AgencyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: AgencyScreen(),
    );
  }
}
