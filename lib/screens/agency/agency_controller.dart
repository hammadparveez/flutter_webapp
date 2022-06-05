import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgencyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxDouble contentHeight = Get.height.obs;

  //Controllers
  final ScrollController _controller = ScrollController();

  //Animations
  final animationDuration = const Duration(milliseconds: 1500);
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> translateAnimation;
  late Animation<Offset> slideAnimation;

  //-----------GETTERS------------
  ScrollController get scrollController => _controller;

  @override
  void onInit() {
    animationController =
        AnimationController(vsync: this, duration: animationDuration);
    final curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutCubic);
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    translateAnimation =
        Tween<double>(begin: 80, end: 0).animate(curvedAnimation);
    slideAnimation = Tween<Offset>(begin: Offset(0, 100), end: Offset(0, 0))
        .animate(animationController);
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
        : animationController.animateBack(0);
  }

  bool onScrollNotification(notification) {
    log("Notifications  and ${notification.metrics.pixels}");
    if (notification.metrics.pixels > Get.height * .5) {
      animationController.forward();
      // contentHeight.value = Get.height * .5;
    } else {
      // animationController.reverse();
    }
    return true;
  }
}
