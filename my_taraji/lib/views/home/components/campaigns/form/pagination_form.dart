import '../../../import.dart';

class PaginationForm extends StatefulWidget {
  const PaginationForm({super.key, required this.campaign});
  final Campaign campaign;

  @override
  PaginationFormState createState() => PaginationFormState();
}

class PaginationFormState extends State<PaginationForm> {
  List<Widget> pages = <Widget>[];
  PageController pageController = PageController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int currentPage = 0;
  bool isLoading = false;

  @override
  initState() {
    super.initState();
    pages = manageInput(widget.campaign);

    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
  }

  _submitForm() async {
    CampaignService campaignService = CampaignService();
    CampaignResponse response = await submitForm(
      pages: pages,
      campaign: widget.campaign,
    );
    if (formKey.currentState!.validate()) {
      await campaignService.submitCampaignAnswers(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: PageView(
                controller: pageController,
                children: pages,
              ),
            ),
          ),
          bottomBar(context)
        ],
      ),
    );
  }

  updateCurrentPage(int increment) {
    setState(() {
      currentPage += increment;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget bottomBar(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        if (currentPage > 0)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.yellow,
            ),
            onPressed: () {
              updateCurrentPage(-1);
            },
            child: const Text(
              '<',
              style: TextStyle(color: MyColors.white),
            ),
          ),
        if (currentPage < pages.length - 1)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.yellow,
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                updateCurrentPage(1);
              }
            },
            child: const Text(
              '>',
              style: TextStyle(color: MyColors.white),
            ),
          ),
        if (currentPage == pages.length - 1)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.yellow,
            ),
            onPressed: isLoading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        _submitForm();
                      } finally {
                        setState(
                          () {
                            isLoading = false;
                            Navigator.of(context).popAndPushNamed("/");
                            openDialog(context, widget.campaign);
                          },
                        );
                      }
                    }
                  },
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: MyColors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                : const Text(
                    'Envoyer',
                    style: TextStyle(color: MyColors.white),
                  ),
          ),
      ],
    );
  }
}
