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

  Widget website(BuildContext context, String url) {
    return WebViewWidget(
      controller: WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0xffffffff))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(url)),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    showCloseIcon: true,
                    content: Text(
                      'Une erreur interne s\'est produite, veuillez contacter le support  par mail Apps@trendit.fr',
                    ),
                    backgroundColor: Colors.black,
                    duration: const Duration(seconds: 5),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(20),
                  ),
                );
                context.read<RechargeProvider>().setStep('finishRecharge');
                return Container();
              } else if (snapshot.data!.data.isSuccess == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    showCloseIcon: true,
                    content: Text('Une erreur avec la banque s\'est produite'),
                    backgroundColor: Colors.black,
                    duration: const Duration(seconds: 5),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(20),
                  ),
                );
                context.read<RechargeProvider>().setStep('finishRecharge');
                return Container();
              } else if (snapshot.data!.data.isIziAuthenticated == false) {
                return Container();
                //  FanPayIzi(
                //   authDetails: authDetails,
                //   user: userData,
                // );
              } else {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .7,
                  child: RechargeWebView(
                    url: snapshot.data!.data.data.paymentUrl,
                  ),
                  // website(
                  //   context,
                  //   snapshot.data!.data.data.paymentUrl,
                  // ),
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
