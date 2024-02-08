import 'package:flutter/cupertino.dart';
// import 'package:my_taraji/core/theme/style.dart';
import 'package:my_taraji/views/crowdfunding/components/crowdfunding_content.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/home/models/crowdfunding.dart';
// import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class CrowdfundingPage extends StatelessWidget {
  const CrowdfundingPage({super.key, this.crowdfunding});
  final Crowdfunding? crowdfunding;
  static String routeName = "/crowdfunding";

  @override
  Widget build(BuildContext context) {
    return CrowdFundContent(crowdfunding: crowdfunding);
  }
}

// class CrowdfundingPage extends StatefulWidget {
//   final Crowdfunding? crowdfunding;
//   const CrowdfundingPage({super.key, this.crowdfunding});
//   static String routeName = "/crowdfunding";

//   @override
//   State<CrowdfundingPage> createState() => _CrowdfundingPageState();
// }

// class _CrowdfundingPageState extends State<CrowdfundingPage> {
//   List<String> images = [
//     "https://images.pexels.com/photos/47730/the-ball-stadion-football-the-pitch-47730.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//     "https://images.pexels.com/photos/1884574/pexels-photo-1884574.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
//   ];
//   int activePage = 0;

//   show(BuildContext context, Widget content) {
//     showModalBottomSheet(
//       // enableDrag: false,
//       useRootNavigator: true,
//       // barrierColor: Colors.black.withOpacity(0),
//       isDismissible: false,
//       scrollControlDisabledMaxHeightRatio: 1,
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (BuildContext context) {
//         // ignore: deprecated_member_use
//         return WillPopScope(
//           onWillPop: () async {
//             return true;
//           },
//           child: content,
//         );
//       },
//     );
//   }

//   List<Widget> indicators(imagesLength, currentIndex) {
//     return List<Widget>.generate(imagesLength, (index) {
//       return Container(
//         margin: const EdgeInsets.all(3),
//         width: 10,
//         height: 10,
//         decoration: BoxDecoration(
//             color: currentIndex == index ? MyColors.white : MyColors.grey,
//             shape: BoxShape.circle),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     const contributionRatio = 0;
//     // widget.crowdfunding!.totalAmountContributed! /
//     //     widget.crowdfunding!.targetAmount!;
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: MyColors.transparent,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: MyColors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Stack(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: 255,
//               child: PageView.builder(
//                   itemCount: 2,
//                   pageSnapping: true,
//                   onPageChanged: (page) {
//                     setState(() {
//                       activePage = page;
//                     });
//                   },
//                   itemBuilder: (context, pagePosition) {
//                     return FittedBox(
//                       fit: BoxFit.cover,
//                       child: Image.network(images[pagePosition]),
//                     );
//                   }),
//             ),
//             Positioned(
//               right: MediaQuery.of(context).size.width / 2.2,
//               top: 200,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: indicators(images.length, activePage),
//               ),
//             ),
//             Positioned(
//               top: -20,
//               left: 0,
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height - 220,
//                 margin: const EdgeInsets.only(top: 250),
//                 padding: const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(
//                   color: MyColors.yellow,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.crowdfunding!.title,
//                           style: stylePrimary.copyWith(fontSize: 23),
//                         ),
//                         const SizedBox(height: 5),
//                         Text.rich(
//                           TextSpan(
//                             text:
//                                 '${widget.crowdfunding!.totalAmountContributed} TND ',
//                             style: stylePrimary.copyWith(
//                               fontSize: 25,
//                               color: MyColors.red,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             children: <InlineSpan>[
//                               TextSpan(
//                                 text:
//                                     '/ ${widget.crowdfunding!.targetAmount} TND',
//                                 style: stylePrimary.copyWith(
//                                   fontSize: 20,
//                                   color: MyColors.red,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Stack(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(20),
//                               child: SimpleAnimationProgressBar(
//                                 height: 44,
//                                 width: MediaQuery.of(context).size.width - 20,
//                                 backgroundColor: MyColors.white,
//                                 foregrondColor: MyColors.red,
//                                 ratio: 0.0,
//                                 direction: Axis.horizontal,
//                                 curve: Curves.fastLinearToSlowEaseIn,
//                                 duration: const Duration(seconds: 3),
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                   color: MyColors.red,
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               left: MediaQuery.of(context).size.width / 2.75,
//                               top: 26,
//                               child: Text(
//                                 "${contributionRatio * 100}%",
//                                 style: stylePrimary.copyWith(
//                                   fontSize: 20,
//                                   color: contributionRatio > 0.59
//                                       ? MyColors.white
//                                       : MyColors.black,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Row(
//                           children: [
//                             const Icon(
//                               TablerIcons.users,
//                               size: 30,
//                               color: MyColors.red,
//                             ),
//                             const SizedBox(width: 10),
//                             Text(
//                               '${widget.crowdfunding!.audienceSize} donateurs',
//                               style: stylePrimary.copyWith(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w400,
//                                 color: MyColors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         Text(
//                           widget.crowdfunding!.description ?? '',
//                           style: stylePrimary.copyWith(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         const SizedBox(height: 35),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             InkWell(
//                               child: Container(
//                                 height: 50,
//                                 width: 180,
//                                 decoration: BoxDecoration(
//                                   color: MyColors.red,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Icon(
//                                       CupertinoIcons.heart_solid,
//                                       color: MyColors.yellow,
//                                       size: 26,
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Text(
//                                       'Participer',
//                                       style: stylePrimary.copyWith(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w700,
//                                         color: MyColors.yellow,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               onTap: () => show(
//                                 context,
//                                 const ManageDonPage(),
//                               ),
//                             ),
//                             Container(
//                               height: 50,
//                               width: 90,
//                               decoration: BoxDecoration(
//                                 color: MyColors.yellow,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: MyColors.red,
//                                   width: 2,
//                                 ),
//                               ),
//                               child: const Icon(
//                                 TablerIcons.send,
//                                 color: MyColors.red,
//                                 size: 32,
//                               ),
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 30),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
