import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orginone/dart/controller/setting/setting_controller.dart';
import 'package:orginone/dart/core/chat/message/msgchat.dart';
import 'package:orginone/dart/core/getx/frequently_used_list/base_frequently_used_item.dart';
import 'package:orginone/dart/core/getx/frequently_used_list/base_frequently_used_list_page_view.dart';
import 'package:orginone/pages/chat/widgets/chat_item.dart';
import 'package:orginone/routers.dart';
import 'package:orginone/widget/gy_scaffold.dart';

import 'message_chats_controller.dart';
import 'message_chats_state.dart';

class MessageChats extends BaseFrequentlyUsedListPage<MessageChatsController,
    MessageChatsState> {
  @override
  Widget buildView() {
    var topChats = state.setting.chat.topChats;

    var chats = state.setting.chat.chats;

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            var chat = topChats[index];
            return MessageItemWidget(chat: chat,callback: (){
              controller.setMostUsed(chat);
            },);
          }, childCount: topChats.length),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            var chat = chats[index];
            return MessageItemWidget(chat: chat,callback: (){
              controller.setMostUsed(chat);
            },);
          }, childCount: chats.length),
        ),
      ],
    );
  }

  @override
  MessageChatsController getController() {
    return MessageChatsController();
  }

  @override
  bool displayNoDataWidget() {
    // TODO: implement displayNoDataWidget
    return false;
  }

  @override
  void onTapRecent(recent) {
    if(recent is MessageRecent){
      recent.chat.onMessage();
      Get.toNamed(
        Routers.messageChat,
        arguments: recent.chat,
      );
    }

  }

  @override
  String tag() {
    // TODO: implement tag
    return "MessageChats";
  }
}




