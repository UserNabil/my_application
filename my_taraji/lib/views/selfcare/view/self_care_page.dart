import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/components/background_top.dart';
import 'package:my_taraji/core/components/custom_card.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/core/theme/style.dart';
import 'package:my_taraji/views/init/providers/init_taraji_provider.dart';
import 'package:my_taraji/views/selfcare/models/pages_enum.dart';
import 'package:my_taraji/views/selfcare/provider/self_care_provider.dart';
import 'package:my_taraji/views/selfcare/view/widget_builder.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Provider.of<SelfCareProvider>(context, listen: false).page ==
                PageViewEnum.selfcare) {
              context.read<InitProvider>().initCurrentIndex();
              Navigator.popAndPushNamed(context, "/");
            } else {
              context
                  .read<SelfCareProvider>()
                  .switchPage(PageViewEnum.selfcare);
            }
          },
        ),
        title: Text(
            appBarTitle(
              Provider.of<SelfCareProvider>(context, listen: false).page,
            ),
            style: styleAppBarTitle),
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
      body: Stack(
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
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                // the body of the page
                child: selfCareBody(context.watch<SelfCareProvider>().page),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
      //
    );
  }
}
