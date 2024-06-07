import 'package:startup_boilerplate/controllers/common/sp_controller.dart';
import 'package:startup_boilerplate/models/home/repo_list_model.dart';
import 'package:startup_boilerplate/services/api_services.dart';
import 'package:startup_boilerplate/utils/constants/imports.dart';

class HomeController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();

  //* Variables
  final RxBool isRepoListLoading = RxBool(false);
  final RxBool isRepoListPaginationLoading = RxBool(false);
  final RxInt pageNumber = RxInt(1);
  final RxBool repoListScrolled = RxBool(false);
  final Rx<RepoListModel?> repoListData = Rx<RepoListModel?>(null);
  final RxList<Item> repoList = RxList<Item>([]);
  final ScrollController repoListScrollController = ScrollController();
  final Rx<Item?> userRepoInfo = Rx<Item?>(null);
  final TextEditingController tokenTextEditingController = TextEditingController();

  //* API call for list
  Future<void> getRepoList() async {
    try {
      isRepoListLoading.value = true;
      String? token = await spController.getBearerToken();
      String suffixUrl = '?page=$pageNumber';
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "/search/repositories?q=Q?per_page=10$suffixUrl",
      );
      if (response != null) {
        repoList.clear();
        repoListData.value = RepoListModel.fromJson(response);
        repoList.addAll(repoListData.value!.items!);
        repoListScrolled.value = false;
        isRepoListLoading.value = false;
      } else {
        isRepoListLoading.value = true;
        showSnackBar(title: ksError.tr, message: ksSomethingWentWrong, color: cRedColor);
      }
    } catch (e) {
      isRepoListLoading.value = true;
      ll('getRepoList error: $e');
    }
  }

  //* API call for pagination
  Future<void> getMoreRepoList() async {
    try {
      isRepoListPaginationLoading.value = true;
      String? token = await spController.getBearerToken();
      String suffixUrl = '?page=${pageNumber + 1}';
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "/search/repositories?q=Q?per_page=10$suffixUrl",
      );
      if (response != null) {
        repoListData.value = RepoListModel.fromJson(response);
        repoList.addAll(repoListData.value!.items!);
        repoListScrolled.value = false;
        isRepoListPaginationLoading.value = false;
      } else {
        isRepoListPaginationLoading.value = false;
        showSnackBar(title: ksError.tr, message: ksSomethingWentWrong, color: cRedColor);
      }
    } catch (e) {
      isRepoListPaginationLoading.value = false;
      ll('getMoreRepoList error: $e');
    }
  }

  //* Other functions
  void routeToUserProfile(Item item) {
    userRepoInfo.value = item;
    Get.toNamed(krUserProfile);
  }

  void saveToken(token) async {
    await spController.saveBearerToken(token);
  }
}
