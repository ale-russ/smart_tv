import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';

class KbinitialBinding implements Bindings {
  @override
  void dependencies() {
    print("in binding ");
    Get.lazyPut<IntentController>(() => IntentController(), fenix: true);
    Get.lazyPut<GlobalController>(() => GlobalController());
    Get.put(IntentController());
    print("in binding ");
    // Get.put<Service>(()=> Api());
  }
}
