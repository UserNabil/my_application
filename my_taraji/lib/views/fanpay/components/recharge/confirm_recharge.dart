import 'package:gif_view/gif_view.dart';
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

  Widget website(BuildContext context) {
    context.read<RechargeProvider>().initWebViewController();
    return WebViewWidget(
      controller: context.watch<RechargeProvider>().webViewController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .7,
                child: website(context),
              );
            } else {
              return loader();
            }
          },
        ),
      ],
    );
  }
}
