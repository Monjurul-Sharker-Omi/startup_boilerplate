import 'package:startup_boilerplate/controllers/home/home_controller.dart';
import 'package:startup_boilerplate/models/home/repo_list_model.dart';
import 'package:startup_boilerplate/utils/constants/imports.dart';
import 'package:startup_boilerplate/views/widgets/common/utils/custom_app_bar.dart';
import 'package:startup_boilerplate/views/widgets/common/utils/custom_list_tile.dart';
import 'package:startup_boilerplate/views/widgets/common/utils/custom_loading.dart';

class Repositories extends StatelessWidget {
  Repositories({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: "Repositories",
              titleColor: cPrimaryColor,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            width: width,
            child: Obx(
              () => ListView(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  if (homeController.isRepoListLoading.value)
                    const Center(
                      child: CustomLoading(
                        isTextVisible: false,
                      ),
                    ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: homeController.repoList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Item item = homeController.repoList[index];
                        return CustomListTile(
                          leading: ClipOval(
                            child: Container(
                              height: h16,
                              width: h16,
                              decoration: const BoxDecoration(
                                color: cBlackColor,
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                item.owner!.avatarUrl ?? "",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  Icons.person,
                                  size: kIconSize24,
                                  color: cIconColor,
                                ),
                              ),
                            ),
                          ),
                          title: Text(item.name!),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
