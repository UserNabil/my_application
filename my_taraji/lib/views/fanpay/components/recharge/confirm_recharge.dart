import 'package:gif_view/gif_view.dart';
import 'package:my_taraji/services/recharge_service.dart';
import 'package:my_taraji/views/fanpay/components/recharge/recharge_webview.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConfirmRecharge extends StatelessWidget {
  const ConfirmRecharge({super.key});

  Widget loader() {
    return Center(
      heightFactor: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GifView.asset(
            alignment: Alignment.center,
            'images/gifs/loader_paiement.gif',
            frameRate: 30,
          ),
          const Text(
            "Chargement...",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: MyColors.blue2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    RechareService rechareService = RechareService();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder(
          future: rechareService.getPaymentInfo(
            context.watch<RechargeProvider>().numberController.text,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              if (snapshot.data!.isSuccess == false) {
                context.read<RechargeProvider>().setStep('finishRecharge');
                return const Center(
                  child: Text(
                      'Une erreur interne s\'est produite, veuillez contacter le support  par mail Apps@trendit.fr'),
                );
              } else if (snapshot.data!.data.isSuccess == false) {
                // context.read<RechargeProvider>().setStep('finishRecharge');
                return const Center(
                  child: Text('Une erreur avec la banque s\'est produite'),
                );
              } else if (snapshot.data!.data.isIziAuthenticated == false) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: FutureBuilder(
                      future: context.read<FanPayProvider>().getAccountCard(),
                      builder: (context, snapshotAccountCard) {
                        return FutureBuilder(
                            future: context.watch<HomeProvider>().getUserData(),
                            builder: (context, snapshotUserData) {
                              return Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  FanPayIzi(
                                    authDetails: snapshotAccountCard.data,
                                    user: snapshotUserData.data,
                                  ),
                                ],
                              );
                            });
                      }),
                );
              } else {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .7,
                  child: RechargeWebView(
                    url: snapshot.data!.data.data!.paymentUrl,
                  ),
                );
              }
            } else {
              return loader();
            }
          },
        ),
      ],
    );
  }
}
