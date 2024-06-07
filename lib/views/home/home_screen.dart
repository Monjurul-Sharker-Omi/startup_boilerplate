import 'package:startup_boilerplate/controllers/home/home_controller.dart';
import 'package:startup_boilerplate/utils/constants/imports.dart';
import 'package:startup_boilerplate/views/widgets/common/buttons/custom_button.dart';
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
          body: Center(
            child: CustomElevatedButton(
              label: "Get Flutter Repositories",
              onPressed: () async {
                Get.toNamed(krRepositories);
                if (homeController.repoList.isEmpty) {
                  await homeController.getRepoList();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
