import 'package:intl/intl.dart';
import 'package:startup_boilerplate/controllers/home/home_controller.dart';
import 'package:startup_boilerplate/utils/constants/imports.dart';
import 'package:startup_boilerplate/views/profile/widgets/details_widget.dart';
import 'package:startup_boilerplate/views/repositories/widget/avatar_widget.dart';
import 'package:startup_boilerplate/views/widgets/common/utils/custom_app_bar.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});
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
              title: homeController.userRepoInfo.value!.owner!.login,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: ListView(
                children: [
                  kH20sizedBox,
                  Align(
                    alignment: Alignment.center,
                    child: UserAvatar(userImageUrl: homeController.userRepoInfo.value!.owner!.avatarUrl ?? "", size: 150),
                  ),
                  DetailsWidget(info: homeController.userRepoInfo.value!.owner!.login!),
                  DetailsWidget(info: "Last updated at: ${DateFormat('yyyy-MM-dd - kk:mm').format(homeController.userRepoInfo.value!.pushedAt!)}"),
                  DetailsWidget(
                    info: homeController.userRepoInfo.value!.description!,
                    isHTML: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
