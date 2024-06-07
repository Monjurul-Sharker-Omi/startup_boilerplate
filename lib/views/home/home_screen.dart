import 'package:startup_boilerplate/controllers/home/home_controller.dart';
import 'package:startup_boilerplate/utils/constants/imports.dart';
import 'package:startup_boilerplate/views/widgets/common/buttons/custom_button.dart';
import 'package:startup_boilerplate/views/widgets/common/textfield/custom_textfield.dart';
import 'package:startup_boilerplate/views/widgets/common/utils/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
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
              title: "Home",
              titleColor: cPrimaryColor,
              hasBackButton: false,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomModifiedTextField(
                hint: "Enter github token",
                controller: homeController.tokenTextEditingController,
              ),
              kH16sizedBox,
              CustomElevatedButton(
                  label: "Save token",
                  onPressed: () {
                    homeController.saveToken(homeController.tokenTextEditingController.text.trim());
                  }),
              kH16sizedBox,
              CustomElevatedButton(
                label: "Get Flutter Repositories",
                onPressed: () async {
                  Get.toNamed(krRepositories);
                  if (homeController.repoList.isEmpty) {
                    await homeController.getRepoList();
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
