import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_webapp/screens/agency/agency_controller.dart';
import 'package:flutter_webapp/screens/second/second_screen.dart';
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';

//123
class AgencyScreen extends StatefulWidget {
  const AgencyScreen({Key? key}) : super(key: key);

  @override
  State<AgencyScreen> createState() => _AgencyScreenState();
}

class _AgencyScreenState extends State<AgencyScreen> {
  final controller = Get.put(AgencyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.animationController.addListener(() {
      log("Playing Animation");
      setState(() {});
    });
  }

  _onTap(Duration duration) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, animation1, animation2) {
            return SecondScreen();
          },
          transitionDuration: duration, //const Duration(seconds: 2),
          reverseTransitionDuration: duration, //const Duration(seconds: 2),
          fullscreenDialog: false,
          // opaque: false,
          transitionsBuilder: (_, animation1, animation2, child) => child,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final animationEndDuration = const Duration(seconds: 2);
    final Curve curve = Curves.easeInOutSine;
    TimelineTween<Prop> createTween() {
      // (2) create TimelineTween using this enum
      var tween = TimelineTween<Prop>();
      tween
        ..addScene(
          curve: curve,
          begin: Duration(seconds: 0),
          end: animationEndDuration,
        )
            .animate(Prop.i, tween: Tween(end: 0.0, begin: -0.003))
            .animate(Prop.rotateY, tween: Tween(end: 0, begin: 90))
        ..addScene(
          begin: const Duration(milliseconds: 0),
          duration: const Duration(milliseconds: 500),
        ).animate(Prop.opacity, tween: Tween(begin: 1.0, end: 0.0));

      return tween;
    }

    return Transform(
      transform: Matrix4.identity(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconButton(icon: Icon(Icons.menu), onPressed: null),
                Hero(
                  tag: '2nd',
                  flightShuttleBuilder: (_, animation1, flight, ctx, ctx2) {
                    return PlayAnimation<TimelineValue<Prop>>(
                      duration: createTween().duration,
                      //Duration(seconds: 4),
                      tween: createTween(),
                      builder: (ctx, child, value) {
                        debugPrint("Animation $value");
                        return Stack(
                          children: [
                            PlayAnimation<Size>(
                                // delay: const Duration(seconds: 1),
                                curve: curve,
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
                                              opacity: anim.get(Prop.opacity),
                                              child: BookPageWidget());
                                        }),
                                  );
                                },
                                tween: Tween(
                                    begin: Size(ctx2.width, ctx2.height),
                                    end: Size(Get.width, Get.height))),
                            Container(
                              transformAlignment: FractionalOffset.centerLeft,
                              transform: Matrix4.identity()
                                ..setEntry(3, 0, value.get(Prop.i))
                                ..rotateY(
                                    (math.pi / 180) * value.get(Prop.rotateY)),

                              // ..setEntry(3, 0, -0.001),
                              // height: 200,
                              // width: 200,
                              // color: Color.fromARGB(255, 245, 46, 46),
                              child: BookCoverWidget(height: ctx2.height),

                              // Material(child: _buildBody()),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: GestureDetector(
                    onTap: () => _onTap(animationEndDuration),
                    child: _buildBody(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BookCoverWidget();
  }
}

class BookCoverWidget extends StatelessWidget {
  const BookCoverWidget({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          // duration: const Duration(milliseconds: 2000),
          // alignment: FractionalOffset.center,
          transform:
              //Matrix 4x4
              //     Matrix4(
              //   1, 0, 0, 0, //1st Row
              //   .5, 1, 0, 0, //2nd Row
              //   0, 0, 1, 0, //3rd Row
              //   20, 0, 0, 1, //4th Row
              // ),
              //In Matrix4 , Row means Column,
              // setting row will affect column, setting columns will affect row
              Matrix4.identity(),
          // ..translate(40.0, 50, 100)
          // ..setEntry(3, 0, -0.002)
          // ..rotateX((math.pi / 180) * 180)
          // ..rotateY((math.pi / 180) * 8)
          // ..rotateZ((math.pi / 180) * 1),
          // ..setColumn(0, Vector4(1, 0, 0, -0.003)),
          // ..rotateZ((math.pi / 180) * 5),
          //..rotateZ((math.pi / 180) * 1),
          // Matrix4(
          //   1,0,0,0,
          //   0,1,0,0,
          //   0,0,1,0,
          //   0,0,0,1
          //),
          //
          //
          transformAlignment: FractionalOffset.center,
          height: height ?? Get.height - 100,
          width: width ?? Get.width,
          color: Color(0xffDB19DB),
          child: Image.asset(
            'assets/book-cover.png',
            fit: BoxFit.fill,
          )),
    );
  }
}
