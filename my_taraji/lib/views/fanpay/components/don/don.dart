import 'package:flutter/cupertino.dart';
import 'package:my_taraji/core/models/user_model.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class MyDon extends StatefulWidget {
  const MyDon({super.key});

  @override
  MyDonState createState() => MyDonState();
}

class MyDonState extends State<MyDon> {
  DonUI donUI = DonUI();
  List<String> amounts = ["1.000", "5.000", "10.000", "15.000", "25.000"];
  TextEditingController amountController = TextEditingController();
  String step = "don";
  bool isSwitched = true;
  String? userName = "";

  @override
  void initState() {
    super.initState();
    amountController.text = amounts[0];
  }

  Future<UserData> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData userData = UserData(
      id: prefs.getString('id')!,
      pseudo: prefs.getString('name')!,
      phone: prefs.getString('phone')!,
      myRewards: MyRewards(coins: int.parse(prefs.getString('coins')!)),
      myGamification: MyGamification(
        id: prefs.getString('id')!,
        expPoints: int.parse(prefs.getString('xp')!),
        expPointsHistory: [],
        createdAt: '',
        updatedAt: '',
      ),
    );

    return userData;
  }

  setStep(String newStep) {
    setState(() {
      step = newStep;
    });
  }

  setAmount(String newAmount) {
    setState(() {
      amountController.text = newAmount;
    });
  }

  setCashType(bool newSwitch) {
    setState(() {
      isSwitched = newSwitch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(
                color: MyColors.yellow,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Text('Error', style: TextStyle(color: MyColors.red));
        }

        final userData = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(30),
          child: manageStep(userData),
        );
      },
    );
  }

  manageStep(userData) {
    switch (step) {
      case "don":
        return don(userData);
      case "confirmDon":
        return ConfirmDon(
          amountController: amountController,
          step: step,
          cashType: isSwitched,
          setStep: setStep,
          setTypeCash: setCashType,
        );
      case "finishDon":
        return FinishDon(
          amountController: amountController,
          step: step,
        );
    }
  }

  Widget don(userData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.asset(
                'images/pngs/taraji.png',
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData.pseudo,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 15.0),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Don pour Taraji'),
                  ],
                ),
              ],
            )
          ],
        ),
        donUI.divider(40.0),
        const SizedBox(height: 20.0),
        const Text(
          'Définir montant',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 150,
              child: TextField(
                readOnly: isSwitched,
                controller: amountController,
                cursorColor: MyColors.blue,
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(width: 50.0),
            const Text(
              "DT",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        donUI.divider(0.0),
        const SizedBox(height: 20.0),
        Container(
          height: 200,
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: amounts.map((amount) {
              return ElevatedButton(
                onPressed: () {
                  setAmount(amount);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  backgroundColor: const Color(0xffF0F5FF),
                  foregroundColor: const Color(0xff3784FB),
                  surfaceTintColor: const Color(0xffF0F5FF),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '$amount DT',
                    style: const TextStyle(
                      color: Color(0xff3784FB),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SlideAction(
          thumbWidth: 70,
          stretchThumb: true,
          trackHeight: 60,
          trackBuilder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffF0F5FF),
              ),
              child: Center(
                child: Text(
                  state.isPerformingAction
                      ? "Chargement..."
                      : "Glisser pour continuer",
                  style: const TextStyle(
                    color: MyColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
          thumbBuilder: (context, state) {
            return Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: MyColors.orange,
                borderRadius: BorderRadius.circular(30),
              ),
              child: state.isPerformingAction
                  ? const Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        size: 40,
                        TablerIcons.chevrons_right,
                        color: Colors.white,
                      ),
                    ),
            );
          },
          action: () async {
            await Future.delayed(
              const Duration(seconds: 1),
              () {
                setStep("confirmDon");
              },
            );
          },
        ),
      ],
    );
  }
}
