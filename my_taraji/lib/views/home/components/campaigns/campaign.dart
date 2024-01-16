import 'package:my_taraji/views/home/import.dart';

class CampaignPaginationForm extends StatelessWidget {
  const CampaignPaginationForm({super.key, required this.campaign});
  final Campaign campaign;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(
        pages: [
          OnboardingPageModel(
            title: 'Fast, Fluid and Secure',
            description:
                'Enjoy the best of the world in the palm of your hands.',
            imageUrl: 'images/pngs/campaigns/campaigns2.jpg',
            bgColor: MyColors.red,
          ),
          OnboardingPageModel(
            title: 'Connect with your friends.',
            description: 'Connect with your friends anytime anywhere.',
            imageUrl: 'https://i.ibb.co/LvmZypG/storefront-illustration-2.png',
            bgColor: const Color(0xff1eb090),
          ),
          OnboardingPageModel(
            title: 'Bookmark your favourites',
            description:
                'Bookmark your favourite quotes to read at a leisure time.',
            imageUrl: 'https://i.ibb.co/420D7VP/building.png',
            bgColor: const Color(0xfffeae4f),
          ),
          OnboardingPageModel(
            title: 'Follow creators',
            description: 'Follow your favourite creators to stay in the loop.',
            imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
            bgColor: Colors.purple,
          ),
        ],
        campaign: campaign,
      ),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;
  final Campaign campaign;

  const OnboardingPagePresenter(
      {super.key,
      required this.pages,
      this.onSkip,
      this.onFinish,
      required this.campaign});

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isSuccess = false;

  Future<bool> submitMyForm() async {
    List<Widget> pages = <Widget>[];
    CampaignService campaignService = CampaignService();
    CampaignResponse response = await submitForm(
      pages: pages,
      campaign: widget.campaign,
    );
    if (formKey.currentState!.validate()) {
      APIResponseModel<CampaignResponse> finalResponse =
          await campaignService.submitCampaignAnswers(response);
      return finalResponse.isSuccess;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AnimatedContainer(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              MyColors.red,
              MyColors.redDarker,
            ],
          ),
          image: DecorationImage(
            image: AssetImage('images/pngs/campaigns/campaigns2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        duration: const Duration(milliseconds: 250),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.pages.length,
                    onPageChanged: (idx) {
                      setState(() {
                        _currentPage = idx;
                      });
                    },
                    itemBuilder: (context, idx) {
                      final item = widget.pages[idx];
                      return Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 36.0,
                                      bottom: 16,
                                      left: 24,
                                      right: 24),
                                  child: Text(
                                    item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: item.textColor,
                                        ),
                                  ),
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 280),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 8.0),
                                  child: Text(
                                    item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: item.textColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 36.0,
                                      bottom: 16,
                                      left: 24,
                                      right: 24),
                                  child: Text(
                                    item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: item.textColor,
                                        ),
                                  ),
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 280),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 8.0),
                                  child: Text(
                                    item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: item.textColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Current page indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.pages
                      .map((item) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: _currentPage == widget.pages.indexOf(item)
                                ? 30
                                : 8,
                            height: 8,
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                          ))
                      .toList(),
                ),

                // Bottom buttons
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              visualDensity: VisualDensity.comfortable,
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            widget.onSkip?.call();
                          },
                          child: const Text("Ignorer")),
                      TextButton(
                        style: TextButton.styleFrom(
                            visualDensity: VisualDensity.comfortable,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          if (_currentPage == widget.pages.length - 1) {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                isSuccess = await submitMyForm();
                              } finally {
                                isLoading = false;
                                if (isSuccess) {
                                  setState(
                                    () {
                                      Navigator.of(context)
                                          .popAndPushNamed("/");
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
                            }
                          } else {
                            _pageController.animateToPage(_currentPage + 1,
                                curve: Curves.easeInOutCubic,
                                duration: const Duration(milliseconds: 250));
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              _currentPage == widget.pages.length - 1
                                  ? "Finir"
                                  : "Suivant",
                            ),
                            const SizedBox(width: 8),
                            Icon(_currentPage == widget.pages.length - 1
                                ? TablerIcons.check
                                : Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel(
      {required this.title,
      required this.description,
      required this.imageUrl,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}
