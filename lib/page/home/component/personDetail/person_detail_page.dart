import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:orginone/component/form_item_type1.dart';
import 'package:orginone/model/db_model.dart';
import 'package:orginone/page/home/message/chat/chat_controller.dart';
import 'package:orginone/page/home/message/message_controller.dart';
import 'package:orginone/routers.dart';
import '../../home_controller.dart';
import 'person_detail_controller.dart';

class PersonDetailPage extends GetView<PersonDetailController> {
  const PersonDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonDetailController>(
      init: PersonDetailController(),
      builder: (item) => Scaffold(
          appBar: GFAppBar(
            leading: GFIconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
              type: GFButtonType.transparent,
            ),
            title: Text(
                item.personDetail != null ? item.personDetail!.nickName : '',
                style: const TextStyle(fontSize: 24)),
          ),
          backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
          body: Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormItemType1(
                        title: '昵称',
                        text: item.personDetail != null
                            ? item.personDetail!.nickName
                            : '',
                        suffixIcon: const Icon(Icons.keyboard_arrow_right)),
                    const Divider(
                      height: 0,
                    ),
                    FormItemType1(
                        title: '姓名',
                        text: item.personDetail != null
                            ? item.personDetail!.team['name']
                            : '',
                        suffixIcon: const Icon(Icons.keyboard_arrow_right)),
                    const Divider(
                      height: 0,
                    ),
                    FormItemType1(
                        title: '电话',
                        text: item.personDetail != null
                            ? item.personDetail!.team['code']
                            : '',
                        suffixIcon: const Icon(Icons.keyboard_arrow_right)),
                    const Divider(
                      height: 0,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: FloatingActionButton(
                    heroTag: 'one',
                    onPressed: () async {
                      if (controller.personDetail == null) {
                        EasyLoading.showToast("未获取到人员信息！");
                        return;
                      }
                      HomeController homeController = Get.find();
                      MessageController messageController = Get.find();
                      messageController.currentSpaceId =
                          homeController.currentSpace.id;
                      messageController.currentMessageItemId =
                          int.tryParse(controller.personDetail!.id)!;
                      Get.offNamedUntil(
                          Routers.chat,
                          (route) =>
                              (route as GetPageRoute).settings.name ==
                              Routers.home);

                      // MessageController messageController = Get.find();
                      // //循环判断该人员是否在集团里，若有则对话，无则提示
                      // int matchGroupId = -1;
                      // messageController.messageGroupItemsMap.forEach((key, value) {
                      //   List<TargetRelation> matchList = value.where((item) => item.passiveTargetId == int.tryParse(controller.personDetail!.id)).toList();
                      //   if(matchList.isNotEmpty) {
                      //     matchGroupId = key;
                      //   }
                      // });
                      // if(matchGroupId != -1) {
                      //   messageController.currentMessageItemId = int.tryParse(controller.personDetail!.id) ?? -1;
                      //   messageController.currentSpaceId = matchGroupId;
                      //   ChatController chatController = Get.find();
                      //   await chatController.init();
                      //   Get.toNamed(Routers.chat);
                      // } else {
                      //   Fluttertoast.showToast(
                      //       msg: '集团中不存在该人员',
                      //       toastLength: Toast.LENGTH_SHORT,
                      //       gravity: ToastGravity.CENTER,
                      //       timeInSecForIosWeb: 1,
                      //       backgroundColor: Colors.red,
                      //       textColor: Colors.white,
                      //       fontSize: 16.0
                      //   );
                      // }
                    },

                    ///长按提示
                    tooltip: "发送消息",

                    ///设置悬浮按钮的背景
                    backgroundColor: Colors.blueAccent,

                    ///水波纹颜色
                    splashColor: Colors.white,

                    ///配制阴影高度 未点击时
                    elevation: 0.0,

                    ///配制阴影高度 点击时
                    highlightElevation: 25.0,
                    // Text('添加好友',style:TextStyle(fontSize: 10)),
                    child: const Icon(Icons.message,
                        size: 30, color: Colors.white)),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: FloatingActionButton(
                    onPressed: () {
                      Get.toNamed(Routers.personAdd);
                    },
                    tooltip: "添加好友",
                    backgroundColor: Colors.blueAccent,
                    splashColor: Colors.white,
                    elevation: 0.0,
                    highlightElevation: 25.0,
                    // Text('添加好友',style:TextStyle(fontSize: 10)),
                    child: const Icon(Icons.person_add,
                        size: 30, color: Colors.white)),
              )
            ],
          )),
    );
  }
}