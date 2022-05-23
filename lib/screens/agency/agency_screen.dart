import 'package:flutter/material.dart';
import 'package:flutter_webapp/screens/agency/agency_controller.dart';
import 'package:flutter_webapp/utils/colors.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AgencyScreen extends StatelessWidget {
  const AgencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgencyController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.playAnimation();
        },
        splashColor: AppColors.transparent,
        hoverColor: AppColors.transparent,
        child: Icon(Icons.clear),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.clear),
        ),
        actions: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 20),
              child: Text("Hammad Parveez"))
        ],
      ),
      body: NotificationListener(
        onNotification: controller.onScrollNotification,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: FadeTransition(
                  opacity: controller.fadeAnimation, child: Banner()),
            ),
          ],
        ),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final images = [
      "https://framerusercontent.com/modules/assets/2048/e7fNMnQH6aPfoByobLbclPpJ3A~H_gd3I26LLgFWaHDT2bMBJ8a8r5h58XNDCO3EZpA148.jpg",
    ];
    return ResponsiveWrapper(
      maxWidth: 1200,
      defaultScale: true,
      breakpoints: const [
        ResponsiveBreakpoint.resize(480, name: MOBILE),
        ResponsiveBreakpoint.resize(800, name: TABLET),
        ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        ResponsiveBreakpoint.resize(2460, name: '4K'),
      ],
      child: Column(
        children: [
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Agency",
                style:
                    Get.textTheme.headline1?.copyWith(color: AppColors.white),
              ),
              Text(
                "We’re an award winning design agency\nspecialised in art direction, 3D, visual identity\nand web design.",
                style: Get.textTheme.headline5
                    ?.copyWith(fontSize: 26, color: AppColors.white),
              ),
            ],
          ),
          const SizedBox(height: 80),
          _buildGridImages(images),
          const SizedBox(height: 30),
          _buildGridImages(images),
          const SizedBox(height: 30),
          _buildGridImages(images),
        ],
      ),
    );
  }

  SizedBox _buildGridImages(List<String> images) {
    return SizedBox(
      height: 400,
      child: Row(
        children: [
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              images[0],
              fit: BoxFit.cover,
            ),
          )),
          const SizedBox(width: 20),
          Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(images[0], fit: BoxFit.cover))),
        ],
      ),
    );
  }
}
