import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_webapp/screens/agency/agency_screen.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationEndDuration = const Duration(seconds: 2);
    TimelineTween<Prop> createTween() {
      // (2) create TimelineTween using this enum
      var tween = TimelineTween<Prop>();
      tween
        ..addScene(
          // curve: Curves.easeInOut,

          begin: Duration(seconds: 0),
          end: animationEndDuration,
        )
            .animate(Prop.i,
                // shiftEnd: const Duration(seconds: 2),
                tween: Tween(begin: 0.0, end: -0.001))
            .animate(Prop.rotateY, tween: Tween(begin: 0, end: 90))
        ..addScene(
                begin: const Duration(milliseconds: 1500),
                duration: const Duration(milliseconds: 500))
            .animate(Prop.opacity, tween: Tween(begin: 0.0, end: 1.0));

      return tween;
    }

    //Apple
    //banana
    //mango
    return Hero(
      tag: '2nd',
      flightShuttleBuilder: (_, animation1, flight, ctx, ctx2) {
        return Stack(
          children: [
            PlayAnimation<Size>(
                // delay: const Duration(seconds: 1),
                duration: animationEndDuration,
                builder: (context, child, value) {
                  return Container(
                    height: value.height,
                    width: value.width,
                    // color: Colors.purple,
                    child: PlayAnimation<TimelineValue<Prop>>(
                        tween: createTween(),
                        duration: createTween().duration,
                        builder: (context, child, anim) {
                          return Opacity(
                              opacity: anim.get(Prop.opacity), child: child!);
                        },
                        child: BookPageWidget()),
                  );
                },
                tween: Tween(
                    begin: Size(ctx.width, ctx.height),
                    end: Size(ctx2.width, ctx2.height))),
            PlayAnimation<TimelineValue<Prop>>(
              duration: createTween().duration,
              tween: createTween(),
              builder: (ctx, child, value) {
                debugPrint("Animation $value");
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Color(0xFF2B2B1C),
                  ),
                  transformAlignment: FractionalOffset.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 0, value.get(Prop.i))
                    ..rotateY((pi / 180) * value.get(Prop.rotateY)),

                  // ..setEntry(3, 0, -0.001),
                  // height: 200,

                  width: ctx2.width,

                  child: BookCoverWidget(height: ctx2.height),
                  // child: _buildBody(),
                );
              },
            ),
          ],
        );
      },
      // placeholderBuilder: (_, size, child) {
      //   return PlayAnimation<double>(
      //       duration: const Duration(seconds: 4),
      //       builder: (context, child, value) {
      //         return Container(
      //           color: Colors.green,
      //           width: value,
      //           height: value,
      //           child: child,
      //         );
      //       },
      //       tween: Tween(begin: 0, end: size.height * .5));
      // },
      // createRectTween: (rect, rect2) {
      //   final r1 =
      //       Rect.fromLTWH(rect!.left, rect.top, Get.width * .5, rect.height);
      //   final r2 =
      //       Rect.fromLTWH(rect2!.left, rect2.top, Get.width * .5, Get.height);
      //   return RectTween(begin: r1, end: r2);
      // },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BookPageWidget();
  }
}

class BookPageWidget extends StatelessWidget {
  const BookPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(),
          clipBehavior: Clip.hardEdge,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                "What is Lorem Ipsum?\n",
                overflow: TextOverflow.fade,
                textHeightBehavior: TextHeightBehavior(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\n",
                overflow: TextOverflow.fade,
              ),
              Text(
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                overflow: TextOverflow.fade,
              ),
              BackButton(),
            ],
          ),
        ),
      ),
    );
  }
}
