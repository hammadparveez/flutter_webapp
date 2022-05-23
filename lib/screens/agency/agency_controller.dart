import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgencyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ScrollController _controller = ScrollController();
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> translateAnimation;
  ScrollController get scrollController => _controller;

  @override
  void onInit() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(animationController);
    translateAnimation =
        Tween<double>(begin: 200, end: 0).animate(animationController);
    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  playAnimation() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

  bool onScrollNotification(ScrollMetricsNotification notification) {
    return true;
  }
}
