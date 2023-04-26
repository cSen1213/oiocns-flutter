

import 'package:get/get.dart';
import 'package:orginone/dart/base/schema.dart';
import 'package:orginone/dart/core/getx/base_get_state.dart';
import 'package:orginone/pages/work/process_details/logic.dart';
import 'package:orginone/pages/work/state.dart';

class UseTracesState extends BaseGetState{

  ProcessDetailsController processDetailsController = Get.find<ProcessDetailsController>();

  XFlowInstance? get flowInstance => processDetailsController.state.flowInstance.value;

}