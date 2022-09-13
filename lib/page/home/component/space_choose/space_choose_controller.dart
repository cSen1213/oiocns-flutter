import 'package:get/get.dart';
import 'package:orginone/api_resp/user_resp.dart';
import 'package:orginone/page/home/home_controller.dart';

import '../../../../api/company_api.dart';
import '../../../../api_resp/target_resp.dart';
import '../../../../model/db_model.dart';
import '../../../../util/hive_util.dart';

class SpaceChooseController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  UserResp userResp = HiveUtil().getValue(Keys.user);

  late int offset;
  late int limit;
  late List<TargetResp> spaces;

  @override
  void onInit() {
    onLoadSpaces();
    super.onInit();
  }

  Future<void> onLoadSpaces() async {
    offset = 0;
    limit = 20;
    spaces = [];
    await loadMoreSpaces(offset, limit);
  }

  Future<void> loadMoreSpaces(int offset, int limit) async {
    List<dynamic> joined = await CompanyApi.getJoinedCompanys(offset, limit);
    for (var joinedSpace in joined) {
      var space = TargetResp.fromMap(joinedSpace);
      spaces.add(space);

      await space.toTarget().upsert();
      var relation = UserSpaceRelation();
      relation.account = userResp.account;
      relation.targetId = space.id;
      relation.name = space.name;
      await relation.upsert();
    }
    update();
  }
}