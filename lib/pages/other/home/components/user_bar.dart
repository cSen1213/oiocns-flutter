import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orginone/components/unified.dart';
import 'package:orginone/components/widgets/text_avatar.dart';
import 'package:orginone/dart/controller/setting/setting_controller.dart';
import 'package:orginone/routers.dart';

class UserBar extends GetView<SettingController> {
  const UserBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.homeEnum.value != HomeEnum.door) {
        return _other;
      }
      return _door;
    });
  }


  Widget get _other {
    return SizedBox(
      height: 74.h,
      child: Row(children: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            controller.jumpInitiate();
          },
        ),
        Text(controller.homeEnum.value.label),
        const Expanded(child: SizedBox()),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
          constraints: BoxConstraints(maxWidth: 40.w),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {

          },
          constraints: BoxConstraints(maxWidth: 40.w),
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
          constraints: BoxConstraints(maxWidth: 40.w),
        ),
      ]),
    );
  }

  Widget get _door {
    return SizedBox(
      height: 74.h,
      child: Row(children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              controller.jumpSpaces();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _textAvatar(EdgeInsets.only(left: 20.w)),
                Container(margin: EdgeInsets.only(left: 10.w)),
                Obx(() {
                  return Text(
                    controller.signed ? controller.space.teamName : "",
                    style: XFonts.size22Black0,
                    overflow: TextOverflow.ellipsis,
                  );
                }),
                Container(margin: EdgeInsets.only(left: 2.w)),
                const Icon(Icons.arrow_drop_down, color: XColors.black)
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: GestureDetector(
            child: _imgAvatar(EdgeInsets.only(right: 10.w)),
            onTap: () {
              Get.toNamed(Routers.personPage);
            },
          ),
        ),
      ]),
    );
  }

  Widget _textAvatar(EdgeInsets insets) {
    return Obx(() {
      return TextAvatar(
        radius: 45.w,
        width: 45.w,
        avatarName: controller.user?.name.substring(0, 1) ?? "",
        textStyle: XFonts.size22White,
        margin: insets,
      );
    });
  }

  Widget _imgAvatar(EdgeInsets insets) {
    return Obx(() {
      var avatar = controller.signed
          ? controller.space.shareInfo.avatar?.thumbnail
              ?.split(",")[1]
              .replaceAll('\r', '')
              .replaceAll('\n', '')
          : "";
      return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: MemoryImage(
              base64Decode(avatar ?? ""),
            ))),
        width: 45.w,
        margin: insets,
      );
    });
  }
}