// ignore_for_file: deprecated_member_use

import '../../../import.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';

class FormWithImage extends StatefulWidget {
  final Campaign campaign;
  final TextEditingController formWithImageController;
  final QuestionCampaign? question;

  const FormWithImage({
    super.key,
    required this.campaign,
    required this.formWithImageController,
    this.question,
  });

  @override
  FormWithImageState createState() => FormWithImageState();
}

class FormWithImageState extends State<FormWithImage> {
  bool isLoading = false;
  bool isSuccess = false;
  List<Widget> pages = <Widget>[];
  List<Meta> groupedValue = [];

  @override
  initState() {
    super.initState();
    pages = manageInput(widget.campaign);
    groupedValue = widget.question!.metas;
  }

  Future<bool> _submitForm() async {
    CampaignService campaignService = CampaignService();
    CampaignResponse response = await submitForm(
      pages: pages,
      campaign: widget.campaign,
    );
    APIResponseModel<CampaignResponse> finalResponse =
        await campaignService.submitCampaignAnswers(response);

    return finalResponse.isSuccess;
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(widget.question!.description),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 100,
          child: InkWell(
            onTap: isLoading
                ? () {
                    isLoading = true;
                  }
                : () async {
                    try {
                      isSuccess = await _submitForm();
                      launchURL(groupedValue[0].value);
                    } finally {
                      isLoading = false;
                      if (isSuccess) {
                        setState(
                          () {
                            Navigator.of(context).popAndPushNamed("/");

                            openDialog(context, widget.campaign);
                          },
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        showMySnackBar(
                          'Envoi de votre demande échoué',
                          MyColors.red,
                          context,
                        );
                      }
                    }
                  },
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      groupedValue[1].value,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Cliquez ici !",
                    style: TextStyle(
                      color: MyColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: MyColors.black,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
