import 'package:startup_boilerplate/utils/constants/imports.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.userImageUrl});
  final String userImageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: h40,
        width: h40,
        decoration: const BoxDecoration(
          color: cBlackColor,
          shape: BoxShape.circle,
        ),
        child: Image.network(
          userImageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.person,
            size: kIconSize24,
            color: cIconColor,
          ),
        ),
      ),
    );
  }
}
