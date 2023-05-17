import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:orginone/dart/base/api/kernelapi.dart';
import 'package:orginone/dart/controller/setting/setting_controller.dart';
import 'package:orginone/dart/core/chat/msgchat.dart';
import 'package:orginone/dart/core/enum.dart';
import 'package:orginone/pages/chat/widgets/avatars.dart';
import 'package:orginone/routers.dart';
import 'package:orginone/util/widget_util.dart';
import 'package:orginone/widget/template/choose_item.dart';
import 'package:orginone/widget/template/originone_scaffold.dart';
import 'package:orginone/widget/unified.dart';
import 'package:orginone/widget/widgets/team_avatar.dart';

import '../../dart/base/model.dart';

Size defaultBtnSize = Size(400.w, 70.h);

class MessageSetting extends GetView<SettingController> {
  const MessageSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrginoneScaffold(
      appBarLeading: WidgetUtil.defaultBackBtn,
      appBarElevation: 0,
      body: _body(context, Get.arguments),
    );
  }

  Widget _body(BuildContext context, IChat chat) {
    List<Widget> children = [];
    if (chat.shareInfo.typeName == TargetType.person.label) {
      children = [
        _avatar(chat),
        Padding(padding: EdgeInsets.only(top: 50.h)),
        _interruption,
        _top,
        _searchChat(chat),
      ];
    } else {
      children = [
        _avatar(chat),
        Padding(padding: EdgeInsets.only(top: 50.h)),
        Avatars(
          persons: chat.members,
          addCallback: () {
            // Map<String, dynamic> args = {
            //   "spaceId": chat.spaceId,
            //   "messageItemId": chat.chatId
            // };
            // Get.toNamed(Routers.invite, arguments: args);
          },
        ),
        _interruption,
        _top,
        _searchChat(chat),
      ];
    }

    // 如果是群组,就有退出群组
    var isPerson = chat.shareInfo.typeName != TargetType.person.label;
    if (isPerson) {
      children.add(Padding(padding: EdgeInsets.only(top: 20.h)));
      children.add(_exitTarget(context, chat));
    }

    // 个人空间的, 有特殊按钮
    if (chat.belongId == controller.user.metadata.id) {
      // 如果是好友, 添加删除好友功能
      if (isPerson) {
        children.add(Padding(padding: EdgeInsets.only(top: 20.h)));
        children.add(_exitTarget(context, chat));
      }
      // 个人空间可以清空会话
      children.add(Padding(padding: EdgeInsets.only(top: 20.h)));
      children.add(_clear(context, chat));
    }
    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      color: XColors.navigatorBgColor,
      child: ListView(children: children),
    );
  }

  /// 头像相关
  Widget _avatar(IChat chat) {
    var messageItem = chat.chatdata.value;
    String name = messageItem.chatName??"";
    if (messageItem.labels?.contains(TargetType.person.label)??false) {
      name += "(${chat.members.length})";
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TeamAvatar(info: TeamTypeInfo(userId: chat.chatId)),
        Padding(padding: EdgeInsets.only(left: 10.w)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: XFonts.size22Black3W700),
              Text(messageItem.chatRemark ?? "", style: XFonts.size16Black6,maxLines: 2,overflow: TextOverflow.ellipsis,)
            ],
          ),
        )
      ],
    );
  }

  /// 消息免打扰
  get _interruption {
    return ChooseItem(
      padding: EdgeInsets.zero,
      header: Text(
        "消息免打扰",
        style: XFonts.size20Black3W700,
      ),
      operate: Switch(value: false, onChanged: (value) {}),
    );
  }

  /// 置顶聊天
  get _top {
    return ChooseItem(
      padding: EdgeInsets.zero,
      header: Text(
        "置顶聊天",
        style: XFonts.size20Black3W700,
      ),
      operate: Switch(
        value: false,
        onChanged: (value) {},
      ),
    );
  }

  /// 查找聊天记录
  Widget _searchChat(IChat chat) {
    return ChooseItem(
      func: (){
        KernelApi.getInstance().queryCohortImMsgs(IDBelongReq(id: chat.chatId));
      },
      padding: EdgeInsets.zero,
      header: Text(
        "查找聊天记录",
        style: XFonts.size20Black3W700,
      ),
      operate: Icon(
        Icons.keyboard_arrow_right,
        size: 32.w,
      ),
    );
  }

  /// 清空聊天记录
  Widget _clear(BuildContext context, IChat chat) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(defaultBtnSize),
        backgroundColor: MaterialStateProperty.all(XColors.themeColor),
      ),
      onPressed: () {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("您确定清空与${chat.chatdata.value.chatName}的聊天记录吗?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('取消'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('确定'),
                  onPressed: () async {
                    Navigator.pop(context);
                    await chat.clearMessage();
                    Fluttertoast.showToast(msg: "清空成功!");
                  },
                ),
              ],
            );
          },
        );
      },
      child: Text(
        "清空聊天记录",
        style: XFonts.size22WhiteW700,
      ),
    );
  }

  /// 删除好友
  Widget _exitTarget(BuildContext context, IChat chat) {
    String remark = "";
    String btnName = "";
    if (chat.chatdata.value.labels?.contains(TargetType.person.label)??false) {
      remark = "您确定删除好友${chat.chatdata.value.chatName}吗?";
      btnName = "删除好友";
    } else {
      remark = "您确定退出${chat.chatdata.value.chatName}吗?";
      btnName = "退出群聊";
    }
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(defaultBtnSize),
        backgroundColor: MaterialStateProperty.all(XColors.backColor),
      ),
      onPressed: () {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(remark),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('取消'),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('确定'),
                  onPressed: () async {
                    Navigator.pop(context);
                    Get.until((route) => route.settings.name == Routers.home);
                  },
                ),
              ],
            );
          },
        );
      },
      child: Text(btnName, style: XFonts.size22WhiteW700),
    );
  }
}