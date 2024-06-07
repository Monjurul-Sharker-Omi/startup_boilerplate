import 'package:flutter/rendering.dart';
import 'package:startup_boilerplate/controllers/home/home_controller.dart';
import 'package:startup_boilerplate/models/home/repo_list_model.dart';
import 'package:startup_boilerplate/utils/constants/imports.dart';
import 'package:startup_boilerplate/views/repositories/widget/avatar_widget.dart';
import 'package:startup_boilerplate/views/repositories/widget/rating_widget.dart';
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
              () => NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (homeController.repoListScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                      scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                      !homeController.isRepoListPaginationLoading.value) {
                    homeController.isRepoListPaginationLoading.value = true;
                    if (homeController.repoList.isNotEmpty) {
                      homeController.getMoreRepoList();
                    }
                    return true;
                  }
                  return false;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: ListView(
                    controller: homeController.repoListScrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      if (homeController.isRepoListLoading.value)
                        const Center(
                          child: CustomLoading(
                            isTextVisible: false,
                          ),
                        ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => kH16sizedBox,
                        itemCount: homeController.repoList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Item item = homeController.repoList[index];
                          return CustomListTile(
                            onPressed: (){
                              homeController.routeToUserProfile(item);
                            },
                            padding: const EdgeInsets.all(k16Padding),
                            spacing: h8,
                            itemColor: cGreyBoxColor,
                            borderColor: cBlackColor,
                            leading: UserAvatar(
                              size: h40,
                              userImageUrl: item.owner!.avatarUrl ?? "",
                            ),
                            title: Text(
                              item.name!,
                              style: semiBold16TextStyle(cBlackColor),
                            ),
                            subtitle: Text(
                              "Owner: ${item.owner!.login}",
                              style: regular16TextStyle(cIconColor),
                            ),
                            trailing: RatingWidget(
                              rating: item.score!,
                            ),
                          );
                        },
                      ),
                      if (homeController.repoList.isNotEmpty && homeController.isRepoListPaginationLoading.value)
                        const Padding(
                          padding: EdgeInsets.only(top: h10),
                          child: CustomLoading(
                            isTextVisible: false,
                          ),
                        ),
                      kH30sizedBox
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
