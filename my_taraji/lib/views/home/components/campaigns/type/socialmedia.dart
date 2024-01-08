import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
// import 'package:share_plus/share_plus.dart';

class SocialMediaInput extends StatelessWidget {
  const SocialMediaInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(10, 30),
          foregroundColor: Colors.white,
          backgroundColor: MyColors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          // await Share.share("https://www.facebook.com/reel");
        },
        child: const Text("Partager"),
      ),
    );

    // String type = 'page';
    // String metas =
    //     'https://www.facebook.com/reel/1513529922765423?sfnsn=scwspmo&s=F5x8gs&fs=e';
    // String link = Uri.encodeFull(metas);
    // String iframeSrc =
    //     'https://www.facebook.com/plugins/post.php?href=$link&show_text=true&height=500';

    // String iframePage =
    //     'https://www.facebook.com/v2.8/plugins/page.php?app_id=593446161742471&href=$link&show_text=true';

    // String iframeToShare = type == 'src' ? iframePage : iframeSrc;

    // return WebView(
    //   initialUrl: Uri.dataFromString(
    //     '''
    //   <html>
    //     <body style="margin: 0; padding: 0;">
    //       $iframeToShare
    //     </body>
    //   </html>
    //   ''',
    //     mimeType: 'text/html',
    //   ).toString(),
    //   javascriptMode: JavascriptMode.unrestricted,
    // );
  }
}
