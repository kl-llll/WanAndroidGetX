import 'dart:ui';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/bean/system_tree_entity.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/widget/custom_neumorphic.dart';

import 'controller.dart';

class SystemPage extends StatelessWidget {
  final controller = Get.find<SystemController>();

  @override
  Widget build(BuildContext context) {
    return GetX<SystemController>(
      init: controller,
      initState: (_) {
        controller.initData();
      },
      builder: (controller) {
        return LoadSir(
            child: ListView(
              children: controller.getTreeList
                  .asMap()
                  .map((key, value) {
                    SystemTreeEntity data = controller.getTreeList[key];

                    return MapEntry(
                        key,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: ExpansionTileCard(
                            expandedTextColor: AppColors.secondColor,
                            baseColor: Get.theme.primaryColor,
                            initialElevation: 1.0,
                            leading: leadingIcon(key),
                            title: titleText(data.name.toString()),
                            onExpansionChanged: (isOpen) {
                              controller.changePosition(isOpen, key);
                            },
                            children: <Widget>[
                              Divider(
                                thickness: 4.0,
                                height: 1.0,
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: data.children!.map((e) {
                                  return Container(
                                    margin: EdgeInsets.all(7),
                                    child: CustomNeumorphic(
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(5)),
                                        child: Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(e.name.toString(), style: TextStyle(fontSize: 13.sp, color: Colors.white,height: 1.1)),
                                        )),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ));
                  })
                  .values
                  .toList(),
            ),
            onPressed: () {},
            controller: controller);
      },
    );
  }

  Container leadingIcon(int key) {
    return Container(
      width: 45.w,
      child: Obx(() {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            AnimatedPositionedDirectional(
              duration: Duration(milliseconds: 300),
              end: key == controller.key.value ? controller.end.value : 15,
              child: CustomNeumorphic(
                boxShape: NeumorphicBoxShape.circle(),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.secondColor),
                  width: 30.r,
                  height: 30.r,
                ),
              ),
            ),
            AnimatedPositionedDirectional(
              duration: Duration(milliseconds: 300),
              end: key == controller.key.value ? 15 - controller.end.value : 1,
              child: CustomNeumorphic(
                boxShape: NeumorphicBoxShape.circle(),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 3,
                            sigmaY: 3,
                          ),
                          child: Container(),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      width: 30.r,
                      height: 30.r,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
