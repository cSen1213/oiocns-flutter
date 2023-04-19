import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:orginone/dart/core/getx/base_get_view.dart';
import 'package:orginone/pages/setting/config.dart';
import 'package:orginone/pages/setting/widget.dart';
import 'package:orginone/widget/common_widget.dart';
import 'package:orginone/widget/gy_scaffold.dart';

import 'logic.dart';
import 'state.dart';

class CompanyInfoPage
    extends BaseGetView<CompanyInfoController, CompanyInfoState> {
  @override
  Widget buildView() {
    return GyScaffold(
      titleName: "公司信息",
      body: SingleChildScrollView(
        child: Column(
          children: [
            companyInfo(),
            SizedBox(
              height: 10.h,
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: CommonWidget.commonNonIndicatorTabBar(
                        state.tabController, tabTitle, onTap: (index) {
                      controller.changeView(index);
                    }),
                  ),
                  CommonWidget.commonPopupMenuButton(
                      items: const [
                        PopupMenuItem(
                          value: CompanyFunction.roleSettings,
                          child: Text("角色设置"),
                        ),
                        PopupMenuItem(
                          value: CompanyFunction.addUser,
                          child: Text("邀请成员"),
                        ),
                        PopupMenuItem(
                          value: CompanyFunction.addGroup,
                          child: Text("加入集团"),
                        ),
                      ],
                      onSelected: (CompanyFunction function) {
                        controller.companyOperation(function);
                      },
                      color: Colors.transparent),
                ],
              ),
            ),
            body(),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return Obx(() {
      if (state.index.value == 1) {
        List<List<String>> groupContent = [];
        for (var group in state.joinGroup) {
          groupContent.add([
            group.name,
            group.target.code,
            group.target.team?.name ?? "",
            group.target.team?.code ?? "",
            group.target.team?.remark ?? ""
          ]);
        }
        return CommonWidget.commonDocumentWidget(
          title: groupTitle,
          content: groupContent,
        );
      }
      return UserDocument(
          popupMenus: const [
            PopupMenuItem(value: 'out', child: Text("踢出")),
          ],
          onOperation: (type,data) {
            controller.removeMember(data);
          }, unitMember: state.unitMember.value,);
    });
  }

  Widget companyInfo() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "当前单位",
            style: TextStyle(fontSize: 21.sp),
          ),
          CommonWidget.commonTextContentWidget(
              "单位名称", state.company?.target.team?.name ?? ""),
          CommonWidget.commonTextContentWidget(
              "社会统一信用代码", state.company?.target.code ?? ""),
          CommonWidget.commonTextContentWidget(
              "团队简称", state.company?.name ?? ""),
          CommonWidget.commonTextContentWidget(
              "团队代号", state.company?.teamName ?? ""),
          CommonWidget.commonTextContentWidget(
              "单位简介", state.company?.target.team?.remark ?? ""),
        ],
      ),
    );
  }
}