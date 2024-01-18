import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/assets/images_svg.dart';
import 'package:my_taraji/core/components/background_top.dart';
import 'package:my_taraji/core/components/custom_card.dart';
import 'package:my_taraji/core/components/top_navigation.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/core/theme/style.dart';
import 'package:my_taraji/views/selfcare/components/selfcare/selfcare_menu.dart';
import 'package:my_taraji/views/selfcare/view/widgets/user_info_widget.dart';

class SelfCarePage extends StatefulWidget {
  const SelfCarePage({super.key});
  static const routeName = '/selfcare';

  @override
  State<SelfCarePage> createState() => _SelfCarePageState();
}

class _SelfCarePageState extends State<SelfCarePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Widget rowItemWidget(
        {required BuildContext context,
        required String title,
        required String location,
        required IconData icon}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: InkWell(
          onTap: () {
            setState(() {
              //widget.onPressed(location);
            });
          },
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  icon,
                  color: MyColors.yellow,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(
                TablerIcons.chevron_right,
                color: MyColors.grey,
              ),
            ],
          ),
        ),
      );
    }

    Widget widgetsToDisplay = Stack(
      children: [
        const CustomContainer(
          colorTo: MyColors.red,
          colorFrom: MyColors.redDarker,
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            SizedBox(height: 70),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: CustomCard(
                svgUrl: '',
                color: MyColors.yellow,
                width: 347,
                height: 237,
              ),
            ),
          ]),
        ),
        Column(
          children: [
            const SizedBox(height: 125),
            Container(
              width: screenSize.width,
              //height: screenSize.height,
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
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
                      title: 'xxczdz',
                      subtitle: '50',
                      imagePath:
                          'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg',
                    ),
                  ),
                  const SizedBox(height: 20),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 17.0, right: 17.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: rows.length,
                        itemBuilder: (context, index) {
                          return rowItemWidget(
                            context: context,
                            title: rows[index].title,
                            location: rows[index].location,
                            icon: rows[index].icon,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SelfCareMenu(onPressed: onPressed, currentContent: currentContent),
            const SizedBox(height: 50),
          ],
        ),
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('profile', style: styleAppBarTitle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(TablerIcons.dots_vertical),
            onPressed: () {},
          ),
        ],
      ),
      body: widgetsToDisplay,
    );
  }
}
