import 'package:my_taraji/services/user_service.dart';
import 'package:my_taraji/views/fanpay/models/transaction_response.dart';

import '../../imports.dart';

class MyFanPay extends StatelessWidget {
  const MyFanPay({super.key});
  static const routeName = '/fanpay';
  static UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    FanPayModal transactionModal = FanPayModal(
      title: "Historiques",
      content: const FanPayHistorique(),
    );

    Widget menuSection(modal, BuildContext thisContext) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Transactions Récentes",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
              ),
              onPressed: () {
                FanPayAction action = FanPayAction(
                  icon: const Icon(
                    size: 20,
                    TablerIcons.filter,
                    color: MyColors.white,
                  ),
                  onTap: () {},
                );
                modal.show(thisContext, action);
                thisContext.read<FanPayProvider>().openModal();
                thisContext.read<FanPayProvider>().initPositionScroller();
              },
              child: const Text(
                "Voir tout",
                style: TextStyle(
                  color: MyColors.blue3,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildPage(User? userData, BuildContext context) {
      List<Widget> widgetsToDisplay = [
        const FanPayMiddleContent(),
        menuSection(transactionModal, context),
        const FanPayBottomContent(),
      ];

      return Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          controller: context.watch<FanPayProvider>().scroll,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 360.0,
              leadingWidth: 180,
              leading: !context.watch<FanPayProvider>().isOpen
                  ? const MyTarajiLogo(
                      logoImagePath: 'images/pngs/taraji.png',
                      firstText: 'My',
                      secondText: 'Taraji',
                      logoSize: 40,
                      textSize: 17,
                      textPosition: TextPositionLogo.right,
                    )
                  : const SizedBox(),
              backgroundColor: MyColors.blue,
              flexibleSpace: const FlexibleSpaceBar(
                background: FanPayTop(),
              ),
              actions: [
                !context.watch<FanPayProvider>().isOpen
                    ? const Padding(
                        padding: EdgeInsets.only(right: 22.0),
                        child: MyProfile(
                          greetingText: 'Bonjour',
                          textPosition: TextPositionLogo.left,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return widgetsToDisplay[index];
                },
                childCount: widgetsToDisplay.length,
              ),
            ),
          ],
        ),
      );
    }

    return FutureBuilder<User?>(
      future: context.watch<HomeProvider>().getUserData(),
      builder: (context, AsyncSnapshot<User?> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (userSnapshot.hasError) {
          return Text('Error: ${userSnapshot.error}');
        }

        User? userData = userSnapshot.data;
        // return Text('Error: ${userData?.mytarajiUser?.isSubscribedIZI}');

        return FutureBuilder<TransactionResponse>(
          future: userService.getAuthDetails(),
          builder: (context,
              AsyncSnapshot<TransactionResponse> authDetailsSnapshot) {
            if (authDetailsSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: MyColors.blue,
                ),
              );
            }

            if (authDetailsSnapshot.hasError) {
              return Text('Error: ${authDetailsSnapshot.error}');
            }
            if (authDetailsSnapshot.hasData) {
              // TransactionResponse? authDetails = authDetailsSnapshot.data;
              // if (userData?.mytarajiUser?.isSubscribedIZI == true &&
              //     authDetails?.isIZIAuthenticated == true &&
              //     authDetails?.isIZIAuthorized == true) {
              return buildPage(userData, context);
              // } else {
              //   return Stack(
              //     alignment: Alignment.topCenter,
              //     children: [
              //       buildPage(userData, context),
              //       FanPayIzi(
              //         authDetails: authDetails,
              //         user: userData,
              //       ),
              //     ],
              //   );
              // }
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
