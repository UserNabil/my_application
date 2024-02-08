import 'package:gif_view/gif_view.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class OverlayLoader extends StatelessWidget {
  const OverlayLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.5),
      child: Center(
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

            // SvgPicture.asset("images/svgs/loader.svg"),
          ],
        ),
      ),
    );
  }
}
