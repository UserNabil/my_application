import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class RechargeFistPage extends StatelessWidget {
  const RechargeFistPage({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    DonUI rechargeUI = DonUI();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Color(0xffE5E7EB),
                    width: 2,
                  ),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  "images/svgs/user_icon.svg",
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Numéro de téléphone",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Color(0xffE5E7EB),
                        width: 2,
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  width: 220,
                  height: 50,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Text("(+216) "),
                          Text(user?.phone ?? "")
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
        rechargeUI.divider(30.0),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(top: 15),
        //       child: rechargeUI.textType1("Payer par", false, true),
        //     ),
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Row(
        //           children: [
        //             Radio(
        //               fillColor: MaterialStateProperty.all(MyColors.orange),
        //               value: 1,
        //               groupValue:
        //                   context.watch<RechargeProvider>().selectedRadio,
        //               onChanged: (int? value) {
        //                 context.read<RechargeProvider>().setSelectRadio(value!);
        //               },
        //             ),
        //             const Text(
        //               "Carte bancaire",
        //               style: TextStyle(fontWeight: FontWeight.w500),
        //             ),
        //           ],
        //         ),
        //         Row(
        //           children: [
        //             Radio(
        //               fillColor: MaterialStateProperty.all(MyColors.orange),
        //               value: 2,
        //               groupValue:
        //                   context.watch<RechargeProvider>().selectedRadio,
        //               onChanged: (int? value) {
        //                 context.read<RechargeProvider>().setSelectRadio(value!);
        //               },
        //             ),
        //             const Text(
        //               "Carte de recharge",
        //               style: TextStyle(fontWeight: FontWeight.w500),
        //             ),
        //           ],
        //         ),
        //       ],
        //     )
        //   ],
        // ),
        // const SizedBox(height: 20),
        // Column(
        //   children: [
        //     Container(
        //       alignment: Alignment.centerLeft,
        //       child: rechargeUI.textType1(
        //           "Numéro de carte de recharge", false, true),
        //     ),
        //     const SizedBox(height: 10),
        //     TextFormField(
        //       inputFormatters: [
        //         GenericMask(
        //           mask: [context.watch<RechargeProvider>().mask],
        //           hashtag: Hashtag.numbers,
        //         )
        //       ],
        //       decoration: InputDecoration(
        //         hintText: context.watch<RechargeProvider>().maskHint,
        //         fillColor: const Color(0xffF1F1FA),
        //         filled: true,
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10),
        //           borderSide: const BorderSide(
        //             width: 0,
        //             style: BorderStyle.none,
        //           ),
        //         ),
        //         suffixIcon: IconButton(
        //           icon: context.watch<RechargeProvider>().icon,
        //           onPressed: () {
        //             // context.read<RechargeProvider>().buildQrView(context);
        //           },
        //         ),
        //       ),
        //     ),
        //     const SizedBox(height: 10),
        //     const Text(
        //       "Entrez le numéro de la carte de recharge ou scannez votre QR code ici",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontSize: 11,
        //         color: Color(0xff333333),
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 40),
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     fixedSize: const Size(300.0, 50.0),
        //     backgroundColor: MyColors.orange,
        //   ),
        //   onPressed: () {
        //     context.read<RechargeProvider>().setStep("finishRecharge");
        //   },
        //   child: const Text(
        //     "Recharger",
        //     style: TextStyle(
        //       color: MyColors.white,
        //       fontSize: 16.0,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        // ),
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
              width: MediaQuery.of(context).size.width * 0.5,
              child: Form(
                key: context.watch<RechargeProvider>().formKey,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller:
                      context.watch<RechargeProvider>().numberController,
                  cursorColor: MyColors.blue3,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer un montant";
                    }

                    return null;
                  },
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
        rechargeUI.divider(0.0),
        const SizedBox(height: 20.0),
        Container(
          height: 200,
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 10.0,
            runSpacing: 20.0,
            children: context
                .watch<RechargeProvider>()
                .rechargeSettings
                .authorizedAmounts
                .map((authorizedAmount) {
              return ElevatedButton(
                onPressed: () {
                  context
                      .read<RechargeProvider>()
                      .setAmount(authorizedAmount.amount);
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
                    '${authorizedAmount.amount} DT',
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
                context.read<RechargeProvider>().setStep("confirmRecharge");
              },
            );
          },
        ),
      ],
    );
  }
}
