import 'package:startup_boilerplate/controllers/common/sp_controller.dart';
import 'package:startup_boilerplate/services/api_services.dart';
import 'package:startup_boilerplate/utils/constants/imports.dart';

class HomeController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();

  final RxBool isPageLoading = RxBool(false);
  // final Rx<TestListModel?> modelData = Rx<TestListModel?>(null);
  // final RxList<ListData> listData = RxList<ListData>([]);
  Future<void> getRepoList() async {
    try {
      isPageLoading.value = true;
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "/search/repositories?q=Q",
      );
      if (response != null) {
        // listData.clear();
        // modelData.value = TestListModel.fromJson(response);
        // listData.addAll(modelData.value!.data!);
        isPageLoading.value = false;
      } else {
        isPageLoading.value = true;

        // ErrorModel errorModel = ErrorModel.fromJson(response.data);
        // if (errorModel.errors.isEmpty) {
        //   showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        // } else {
        //   showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        // }
      }
    } catch (e) {
      isPageLoading.value = true;
      ll('getRepoList error: $e');
    }
  }
}
