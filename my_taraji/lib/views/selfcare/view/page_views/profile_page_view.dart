import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_taraji/core/assets/images_svg.dart';
import 'package:my_taraji/views/selfcare/helpers/data.dart';
import 'package:my_taraji/views/selfcare/view/widgets/button_disconnection.dart';
import 'package:my_taraji/views/selfcare/view/widgets/row_item_widget.dart';
import 'package:my_taraji/views/selfcare/view/widgets/user_info_widget.dart';

class ProfilePageView extends StatelessWidget {
  ProfilePageView({super.key});
  final listRowsWidget = <Widget>[];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    for (var element in rowsAccount) {
      listRowsWidget.add(RowItemWidget(
        title: element.title,
        location: element.location,
        icon: element.icon,
        onTap: () {
          // context.read<SelfCareProvider>().switchPage(element.pageName!);
        },
      ));
    }
    listRowsWidget.add(const Center(child: ButtonDisconnection()));
    listRowsWidget.add(const SizedBox(height: 120));
    return Column(
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          dividerGreySVG,
          height: 5,
          width: 5,
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: UserInfoWidget(
            imagePath:
                'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg',
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: screenSize.height - 315,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Padding(
              padding: const EdgeInsets.only(left: 17.0, right: 17.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listRowsWidget.length,
                itemBuilder: (context, index) {
                  return listRowsWidget[index];
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
