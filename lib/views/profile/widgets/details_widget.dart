import 'package:flutter_html/flutter_html.dart';
import 'package:startup_boilerplate/utils/constants/imports.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key, required this.info, this.isHTML = false});
  final String info;
  final bool isHTML;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: h16),
      child: !isHTML
          ? Text(
              info,
              style: medium16TextStyle(cBlackColor),
            )
          : Html(
              data: info,
              style: {"body": Style(padding: HtmlPaddings.zero, margin: Margins.zero)},
            ),
    );
  }
}
